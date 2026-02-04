
import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { getUserId } from "./utils";
// import { GraphService } from "./services/GraphService"; // We will implement inline or helper if needed

const db = admin.firestore();

// Interfaces
interface GraphNode {
    id: string; // Document ID
    userId: string;
    label: string;
    impactScore: number;
    videoId: string;
    summary: string;
    primarySpeakerId: string;
    references: any[];
    isBookmarked: boolean;
    // ... other fields
}

interface GraphEdge {
    sourceNodeId: string;
    targetNodeId: string;
    weight: number;
    userId: string;
}

interface GraphCategory {
    name: string;
}

interface GraphNodeDisplay {
    name: string;
    nodeId: string;
    videoId: string;
    summary: string;
    primarySpeakerId: string;
    references: any[];
    value: number; // impactScore
    category: number; // index
    symbolSize: number;
    isBookmarked: boolean;
}

interface GraphLinkDisplay {
    source: number; // index in nodeDisplays
    target: number; // index in nodeDisplays
}

interface GraphElements {
    categories: GraphCategory[];
    nodes: GraphNodeDisplay[];
    links: GraphLinkDisplay[];
}

interface GraphGranularity {
    granularity: number;
    graph: GraphElements;
}

interface GraphData {
    graphWithGranularity: GraphGranularity[];
}

export const getGraphData = onCall(async (request) => {
    const userId = getUserId(request);

    // Fetch nodes
    const nodesRef = db.collection("graph_nodes");
    const nodesSnapshot = await nodesRef
        .where("userId", "==", userId)
        .orderBy("impactScore", "desc")
        .get();
        
    const nodes = nodesSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() } as GraphNode));

    // Fetch edges
    const edgesRef = db.collection("graph_edges");
    const edgesSnapshot = await edgesRef
        .where("userId", "==", userId)
        .get();
        
    const edges = edgesSnapshot.docs.map(doc => doc.data() as GraphEdge);

    if (nodes.length === 0) {
        return { graphWithGranularity: [] };
    }

    // Calculate node degrees
    const nodeDegrees: Record<string, number> = {};
    for (const edge of edges) {
        nodeDegrees[edge.sourceNodeId] = (nodeDegrees[edge.sourceNodeId] || 0) + 1;
        nodeDegrees[edge.targetNodeId] = (nodeDegrees[edge.targetNodeId] || 0) + 1;
    }

    const granularities: GraphGranularity[] = [];
    let maxCategoryCount = 3;
    let level = 0;

    // Build granularities
    while (maxCategoryCount < nodes.length) {
        if (level >= 3) break;

        const result = buildGraphWithGranularity(level, maxCategoryCount, nodes, edges, nodeDegrees);
        granularities.push(result.graphGranularity);

        if (result.otherNodeCount <= 4) break;

        maxCategoryCount += 3;
        level++;
    }

    return { graphWithGranularity: granularities };
});

function buildGraphWithGranularity(
    level: number,
    maxCategoryCount: number,
    allNodes: GraphNode[],
    allEdges: GraphEdge[],
    nodeDegrees: Record<string, number>
): { graphGranularity: GraphGranularity, otherNodeCount: number } {
    
    // Filter potential anchors: must have at least 2 edges
    // Note: If ID type checks are needed, ensure consistent string usage
    const candidateAnchors = allNodes.filter(n => (nodeDegrees[n.id] || 0) >= 2);
    
    const validCategoryCount = maxCategoryCount > candidateAnchors.length 
        ? candidateAnchors.length 
        : maxCategoryCount;

    const anchors = candidateAnchors.slice(0, validCategoryCount);
    const anchorIds = new Set(anchors.map(n => n.id));

    // Build Categories
    const categories: GraphCategory[] = anchors.map(n => ({ name: n.label }));

    // Add 'Other' category if needed
    const hasOther = validCategoryCount < allNodes.length;
    if (hasOther) {
        categories.push({ name: 'Other' });
    }

    const nodeDisplays: GraphNodeDisplay[] = [];
    const nodeIdToIndex: Record<string, number> = {};
    let otherNodeCount = 0;

    for (let i = 0; i < allNodes.length; i++) {
        const node = allNodes[i];
        nodeIdToIndex[node.id] = i;

        let categoryIndex: number;
        let symbolSize: number;

        if (anchorIds.has(node.id)) {
            // Anchor
            categoryIndex = anchors.findIndex(a => a.id === node.id);
            symbolSize = 20;
        } else {
            let bestAnchorIndex = -1; // -1 means Other
            
            // Find neighbors and connection weights
            const neighborWeights: Record<string, number> = {};
            for (const edge of allEdges) {
                if (edge.sourceNodeId === node.id) {
                    neighborWeights[edge.targetNodeId] = edge.weight;
                } else if (edge.targetNodeId === node.id) {
                    neighborWeights[edge.sourceNodeId] = edge.weight;
                }
            }
            
            // Check which neighbors are anchors
            let currentMaxWeight = -1.0;
            for (let idx = 0; idx < anchors.length; idx++) {
                const anchor = anchors[idx];
                if (neighborWeights[anchor.id] !== undefined) {
                    const weight = neighborWeights[anchor.id];
                    if (weight > currentMaxWeight) {
                        currentMaxWeight = weight;
                        bestAnchorIndex = idx;
                    }
                }
            }

            if (bestAnchorIndex !== -1) {
                categoryIndex = bestAnchorIndex;
            } else {
                // Assign to Other
                categoryIndex = categories.length - 1;
                otherNodeCount++;
            }
            symbolSize = 10;
        }

        nodeDisplays.push({
            name: node.label,
            nodeId: node.id,
            videoId: node.videoId,
            summary: node.summary,
            primarySpeakerId: node.primarySpeakerId,
            references: node.references,
            value: node.impactScore,
            category: categoryIndex,
            symbolSize: symbolSize,
            isBookmarked: node.isBookmarked
        });
    }

    // Build Links
    const linkDisplays: GraphLinkDisplay[] = [];
    for (const edge of allEdges) {
        const sourceIndex = nodeIdToIndex[edge.sourceNodeId];
        const targetIndex = nodeIdToIndex[edge.targetNodeId];

        if (sourceIndex !== undefined && targetIndex !== undefined) {
            linkDisplays.push({
                source: sourceIndex,
                target: targetIndex
            });
        }
    }

    return {
        graphGranularity: {
            granularity: level,
            graph: {
                categories,
                nodes: nodeDisplays,
                links: linkDisplays
            }
        },
        otherNodeCount
    };
}

export const bookmarkNode = onCall(async (request) => {
    const userId = getUserId(request);
    const { nodeId, isBookmarked } = request.data;
    
    if (!nodeId) throw new HttpsError('invalid-argument', 'nodeId missing');

    const nodeRef = db.collection("graph_nodes").doc(nodeId);
    // Ideally check if user passes permission but assuming auth check & valid ID ownership
    // Actually we should verify userId matches node's userId
    const doc = await nodeRef.get();
    if (!doc.exists) throw new HttpsError('not-found', 'Node not found');
    const data = doc.data();
    if (data?.userId !== userId) throw new HttpsError('permission-denied', 'Not your node');
    
    await nodeRef.update({ isBookmarked });
});

export const getBookmarkedNodes = onCall(async (request) => {
    const userId = getUserId(request);
    
    const nodesRef = db.collection("graph_nodes");
    const snapshot = await nodesRef
        .where("userId", "==", userId)
        .where("isBookmarked", "==", true)
        .get();
        
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
});

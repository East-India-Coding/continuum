# Continuum User Flows & Functionality

This document describes the current user flows and system functionality of the Continuum application and its Knowledge Curator. Use this context to replicate the Continuum experience.

## 1. Application User Flows

### A. Home Dashboard (`HomePage`)
- **Primary Action**: The user inputs a YouTube URL to start the "Podcast Ingestion" process.
- **Visual Feedback**:
  - Displays a real-time progress log (e.g., "Constructing Nodes...", "Extracting Entities").
  - Cyberpunk aesthetic with animated backgrounds and "hacker-style" terminal logs.
- **Transition**: Once ingestion reaches 100%, the app automatically navigates to the Graph Visualization page (`/graph`).

### B. Graph Visualization (`ForceDirectedGraphPage`)
- **Interactive Graph**:
  - Renders a force-directed graph where nodes represent concepts and edges represent relationships.
  - **Node Interaction**: Clicking a node opens a `NodeInfoDialog` displaying details like the summary, speaker, and timestamps.
- **Control Panel (Right Side / Drawer on Mobile)**:
  - **Speaker Filtering**: A checklist allows users to toggle the visibility of nodes based on the speaker.
  - **Granularity Control**: A "Cycle Granularity" button to adjust the density/detail level of the graph.
  - **Chat Panel**: An integrated chat interface to query the knowledge graph (powered by the Knowledge Curator).

## 2. Knowledge Curator Functionality

The "Knowledge Curator" is an agentic system responsible for maintaining and querying the Knowledge Graph. 

### A. Core Curator Tools (Graph Construction)
These tools are used during the ingestion phase to build the graph:
- **`searchSimilarNodes`**: Finds existing nodes semantically similar to a vector embedding to prevent duplicates.
- **`createGraphNode`**: Inserts a new semantic concept (node) into the graph with an impact score and speaker attribution.
- **`createGraphEdge`**: Creates a directed semantic relationship between two nodes.
- **`checkSpeakerIdentity`**: Resolves speaker names to system IDs, creating new speaker records if necessary.
- **`getGraphClusterSummary`**: Retrieves a summary of a node's surrounding neighborhood to understand context before linking.

### B. Conversation Tools (RAG & Retrieval)
These tools are used by the Chat Panel to answer user queries:
- **`searchGraph`**: Performs a semantic vector search on the graph using natural language queries.
- **`traverseGraph`**: Explores the graph starting from specific nodes to find related concepts (multi-hop traversal).
- **`getSpeakerContext`**: Retrieves metadata and statistics about specific speakers.
- **`detectGaps`**: Analyzes retrieved context against the user's question to identify missing information.

## 3. Replication Guidelines
- **Aesthetics**: Maintain the "Cyberpunk/Sci-Fi" visual style (dark mode, neon accents, monospace fonts, glassmorphism).
- **State Management**: The app uses Riverpod for state management (e.g., `homeControllerProvider`, `graphControllerProvider`).
- **Mocking**: Since you lack DB access, you should simulate the responses of the Knowledge Curator tools to demonstrate the flow (e.g., mock a graph structure response after "ingestion").

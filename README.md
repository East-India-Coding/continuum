# Continuum

**A Persistent, Agentic Knowledge System for Long-Form Content**

---

### 🧩 The Problem

We consume hours of long-form content every week—podcasts, lectures, interviews. The problem is not access to information; it's **retention, recall, and connection**.

Existing solutions fail because they are:
1.  **Linear**: Timestamps, transcripts, and summaries are static.
2.  **Stateless**: No long-term memory or evolution.
3.  **Non-compositional**: Ideas don't connect across different pieces of content.
4.  **Passive**: No reasoning or proactive synthesis.

Scrubbing through videos or asking a chatbot repeatedly is not how humans think. We build webs of knowledge.

---
<img width="1919" height="871" alt="Screenshot 2026-02-09 020346" src="https://github.com/user-attachments/assets/e7fc156a-bec6-495e-843c-77d690ba949f" />

### 💡 The Solution

**Continuum** transforms long-form content into a living **Knowledge Graph**. Instead of static summaries, it builds an interactive, evolving system powered by an **Agentic AI Loop** using **Gemini 3.0 Pro**.

Each idea becomes:
-   A **semantically embedded knowledge node**.
-   **Linked** to related ideas across time and sources (e.g., connecting a concept from Episode 10 to Episode 50).
-   **Queryable** through a reasoning agent that traverses the graph.
-   **Persisted** in a PostgreSQL database.

Knowledge compounds instead of disappearing.

---
<img width="1919" height="870" alt="Screenshot 2026-02-09 014545" src="https://github.com/user-attachments/assets/5f08c8a8-d48b-4cfd-a5be-53673d5848e9" />

### 🎯 What Continuum Does

-   **Converts** YouTube podcasts and lectures into structured semantic ideas.
-   **Automatically clusters** related ideas.
-   **Links concepts** based on semantic similarity, not fixed categories.
-   **Preserves** speaker identity and timestamped references.
-   **Enables** agentic question answering grounded in evidence.
-   **Allows** users to explore, save, and revisit ideas visually.

---

### 🧠 How Gemini 3 Is Used

Continuum is built around Gemini 3’s multimodal reasoning and agent capabilities.

#### 1. Multimodal Reasoning
-   **Youtube video + transcript analysis** of long-form content.
-   **Speaker-aware semantic segmentation**.
-   **Timestamp-aligned** idea extraction.

#### 2. Large Context Understanding
-   Gemini reasons over extended sections of content.
-   Preserves **cross-topic coherence**.
-   Avoids fragmented chunking artifacts.

#### 3. Agentic Tool Use
Gemini operates inside a tool-driven agent loop, where it:
-   **Searches** existing knowledge graphs.
-   **Decides** whether ideas are new, redundant, or related.
-   **Creates** nodes and edges using backend tools.
-   **Links** knowledge incrementally across sessions.

#### 4. Agentic Question Answering
Instead of top-k retrieval:
-   Gemini **plans** a reasoning path.
-   **Traverses** relevant subgraphs.
-   **Selects** supporting and conflicting evidence.
-   **Produces** structured, timestamp-cited answers.

---

### 🧬 System Architecture

#### High-Level Flow
```
    A[User Input (YouTube URL)] --> B[Background Ingestion Agent (Gemini 3)]
    B --> C[Semantic Idea Extraction]
    C --> D[Embedding Generation]
    D --> E[Similarity-Based Linking]
    E --> F[Persistent Knowledge Graph]
    F --> G[Agentic Query & Exploration]
```

#### Backend Architecture
```
Serverpod Backend
├── Authentication
├── Background Jobs (Future Calls)
├── Knowledge Curator Agent
│   ├── Tool: Search Similar Nodes
│   ├── Tool: Create Node
│   ├── Tool: Create Edge
│   ├── Tool: Check Speaker Identity
│   └── Tool: Get Graph Cluster Summary
├── PostgreSQL + pgvector
│   ├── Knowledge Nodes
│   ├── Semantic Embeddings
│   ├── Similarity Edges
│   ├── Speaker Entities
│   └── Timestamped References
└── Agentic Answering Layer
```

#### Frontend Architecture
```
Flutter App
├── Force-Directed Knowledge Graph
├── Granularity Controls
├── Speaker Filters
├── Node Inspection Panel
├── Timestamp Jump-to-YouTube
├── Bookmarked Nodes View
└── Agentic Chat Interface
```

---

### 🤖 Agent Design

#### Knowledge Curator Agent
A long-running autonomous agent that:
-   Processes ideas one-by-one.
-   Uses **tools** instead of raw text output.
-   Integrates new knowledge into an existing graph.
-   Maintains consistency and avoids duplication.

#### Agent Tools
-   `searchSimilarNodes(embedding)`
-   `createGraphNode(data)`
-   `createGraphEdge(source, target, weight)`
-   `checkSpeakerIdentityTool(name)`
-   `getGraphClusterSummary(centerNodeId)`

This enables planning, reasoning, and execution, not static inference.

---

### 🔍 Graph Visualization

-   **Force-directed layout**.
-   **Node size** determined by impact score and connectivity.
-   **Semantic proximity** determines spatial clustering.
-   Users can **toggle granularity** to explore ideas at different abstraction levels.

---

### 📈 Why This Is Agentic (and better than a Baseline RAG)

| Feature | Baseline RAG | Continuum |
| :--- | :--- | :--- |
| **Chunking** | Static | Semantic, agent-evaluated |
| **Memory** | Ephemeral | Persistent graph |
| **Reasoning** | Single-pass | Multi-step planning |
| **Knowledge Growth** | Flat | Compounding |
| **Tool Use** | None | Structured tool calls |
| **Adaptation** | None | Graph evolves over time |

---

### 🚀 Demo

The demo showcases:
-   ✅ Podcast ingestion with live progress updates.
-   ✅ Knowledge graph generation.
-   ✅ Interactive exploration.
-   ✅ Agentic question answering with citations.

The system is fully functional and publicly accessible.

---

### 🧠 Why This Matters

Continuum represents a shift from **content consumption** to **cognition infrastructure**.

It demonstrates how Gemini 3 enables:
-   **Autonomous agents**
-   **Long-term memory**
-   **Multimodal reasoning**
-   **Structured knowledge evolution**

> **It’s a thinking system, not another chatbot**

---

### 🏁 Closing

As we enter the **Gemini 3 Action Era**, applications must move beyond static prompts.

Continuum shows what happens when AI:
1.  **Understands deeply**
2.  **Acts autonomously**
3.  **And remembers forever**

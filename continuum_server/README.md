# Continuum Server

The backend service for Continuum, built with **Serverpod**. This server acts as the central coordinator for knowledge ingestion, graph management, and AI agent execution.

## 🏗️ Architecture

The backend is structured around three main pillars:

### 1. Ingestion Pipeline (`IngestionPipeline`)
Orchestrates the flow from raw content to structured knowledge:
-   **YouTube Service**: Fetches video metadata and captions using `youtube_transcript_api`.
-   **LLM Service**: Uses Gemini 3.0 Pro to generate segmented, speaker-aware transcripts.
-   **Graph Service**: Processes each transcript segment through the **Knowledge Curator Agent**.

### 2. Knowledge Curator Agent (`KnowledgeCuratorTools`)
A tool-equipped agent that maintains the integrity of the Knowledge Graph.
-   **State**: Holds temporary embedding registry to optimize token usage.
-   **Tools**:
    -   `searchSimilarNodes`: Vector similarity search (Cosine Distance < 0.35).
    -   `createGraphNode`: Creates `GraphNode` with `impactScore` and `summary`.
    -   `createGraphEdge`: Creates directional `GraphEdge` with weights.
    -   `checkSpeakerIdentityTool`: Unified speaker identity management.
    -   `getGraphClusterSummary`: Retrieves context from a node's neighborhood.

### 3. Graph Query & Chat
-   **Conversational Agent**: Answering engine that queries the graph to answer user questions with citations.

## 🚀 Getting Started

### Prerequisites

-   Docker Desktop (for Postgres & Redis)
-   Dart SDK

### Setup

1.  **Start Infrastructure**:
    ```bash
    docker compose up --build --detach
    ```

2.  **Run Migrations**:
    Ensure your database schema is up to date.
    ```bash
    dart run bin/main.dart --apply-migrations
    ```

3.  **Start the Server**:
    ```bash
    dart bin/main.dart
    ```

### Environment Variables

Ensure you have your specific secrets configured in `config/passwords.yaml` or environment variables for:
-   `geminiApiKey` (for Gemini)
-   Database credentials

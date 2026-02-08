# Continuum Client

The Flutter frontend for Continuum, designed to visually explore and interact with the Knowledge Graph.

## 🎨 Visualization Technology

-   **Graphify**: Uses a custom integration with `graphify` for interactive force-directed graph rendering.
-   **Granularity**: Toggle between high-level conceptual nodes and detailed sub-nodes using semantic clustering.
-   **Speaker Filtering**: Identify and filter nodes contributed by specific speakers.

## 📱 Features

### 1. Interactive Force-Directed Graph
-   **Pan & Zoom**: Standard gestures.
-   **Physics Simulation**: Nodes naturally repel/attract based on semantic distance.
-   **Granularity Cycle**: Cycle through different complexities of the graph (impact driven vs detail driven).
-   **Node Details**: Tap on a node to view its details (summary, impact score, and the exact timestamp of the idea in the video).

### 2. Context-Aware Chat
-   **Agent persona**: Ask questions to "Continuum" or specific personas (e.g. "Ask as Lex Fridman").
-   **Citation Links**: Tap citations in chat answers to jump directly to the exact timestamp in the video.

### 3. Podcast Management
-   **Add Podcast**: Paste a YouTube URL to trigger the backend ingestion pipeline.
-   **Live Updates**: View real-time progress of transcription and graph construction.

## 🚀 Getting Started

### Prerequisites

-   Flutter SDK
-   Continuum Server running (see `../continuum_server/README.md`)

### Setup

1.  **Dependencies**:
    ```bash
    flutter pub get
    ```

2.  **Run**:
    Verify the server is running first, then launch the app:
    ```bash
    flutter run
    ```

    Or for a specific device:
    ```bash
    flutter run -d chrome
    ```

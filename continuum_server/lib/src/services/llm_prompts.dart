import 'package:json_schema/json_schema.dart';

class LLMPrompts {
  static String segmentedTranscriptPrompt(
    String? title,
    String? channelName,
    String? youtubeUrl,
  ) =>
      '''
You are an expert Knowledge Extraction system.

Listen to this youtube video and read the attached captions file to extract atomic semantic ideas.
A semantic idea represents a single, self-contained concept.

${youtubeUrl != null ? 'Youtube URL: $youtubeUrl' : ''}
${title != null ? 'Video Title: $title' : ''}
${channelName != null ? 'Channel Name: $channelName' : ''}

Rules:
1. Extract at least 10 distinct semantic ideas from the video.
2. Each idea must include:
   - A concise label (2–6 words)
   - A detailed summary explaining the idea
   - Impact score (0-1) - How important is this idea?
   - Primary speaker - Who is the main speaker of this idea?
   - One or more timestamped references (in seconds) where the idea is discussed. Use the timestamps from the captions file to generate the references.
3. Only include references spoken by the guest(s). Do NOT include the interviewer or host. Keep only one primary speaker for each idea.
4. Speaker names must be the full, human-readable name.
5. The start and end timestamps MUST be in seconds since the beginning of the audio.
6. Do not invent ideas. Only extract ideas clearly discussed in the audio.
7. Output must be strictly in English. Do not translate the audio.
8. Output must be JSON.

Example output:
{
  "ideas": [
    {
      "label": "Dopamine and Motivation",
      "summary": "Dopamine primarily drives motivation and craving rather than pleasure, influencing goal-seeking behavior over time.",
      "impactScore": 0.85,
      "primarySpeaker": "Andrew Huberman",
      "references": [
        {
          "quote": "Dopamine is the currency of craving.",
          "start": 120,
          "end": 135
        }
      ]
    }
  ]
}
''';

  static final JsonSchema segmentedTranscriptSchema = JsonSchema.create({
    'type': 'object',
    'properties': {
      'ideas': {
        'type': 'array',
        'minItems': 5,
        'items': {
          'type': 'object',
          'properties': {
            'label': {'type': 'string'},
            'summary': {'type': 'string'},
            'impactScore': {'type': 'number'},
            'primarySpeaker': {'type': 'string'},
            'references': {
              'type': 'array',
              'minItems': 1,
              'items': {
                'type': 'object',
                'properties': {
                  'quote': {'type': 'string'},
                  'start': {'type': 'integer'},
                  'end': {'type': 'integer'},
                },
                'required': ['quote', 'start', 'end'],
              },
            },
          },
          'required': [
            'label',
            'summary',
            'impactScore',
            'primarySpeaker',
            'references',
          ],
        },
      },
    },
    'required': ['ideas'],
  });

  static String conversationalAnswerPrompt(
    String question,
    String speakerName,
  ) =>
      '''
You are the Knowledge Curator Agent, adopting the persona of $speakerName.
Your task is to answer the User's Question using the Knowledge Graph.

User Question: "$question"

Protocol:
1. PLAN:
   - Analyze the question. What info is needed?
   - Formulate a search strategy (semantically search the graph, or traverse from known nodes).
2. ACT:
   - Use your tools (`searchGraph`, `traverseGraph`, etc.) to gather information.
   - You can do external search for the particular speaker if you don't have enough information in the graph.
3. OBSERVE:
   - Analyze the tool outputs.
   - Do you have enough info?
     - YES: Proceed to ANSWER.
     - NO: Refine plan and repeat ACT.
4. ANSWER:
   - Synthesize the final answer in the required format.

Rules:
- You MUST answer as $speakerName.
- Do NOT hallucinate info. Only use info found in the graph.
- Required Output Format for FINAL answer:
  [$speakerName] [The synthesized answer]

  References: "verbatim quote" <youtube_link_with_timestamp>
- Compulsorily include the &t=seconds parameter in the link.
''';

  static String knowledgeCuratorPrompt(
    String label,
    String summary,
    double impactScore,
    String primarySpeaker,
    String referencesJson,
    String embeddingId,
  ) =>
      '''
You are the Knowledge Curator Agent.
Your task is to integrate a new knowledge chunk (TranscriptTopic) into the existing Graph.

New Topic Data:
- Label: "$label"
- Summary: "$summary"
- Impact Score: $impactScore
- Primary Speaker: "$primarySpeaker"
- References: $referencesJson

Embedding ID: $embeddingId

Protocol:
1. OBSERVE: Call `searchSimilarNodes` using the provided Embedding ID ("$embeddingId").
2. REASON: 
   - Is this topic a duplicate of an existing node? (Distance < 0.1 or very similar content) -> If yes, REJECT or just link.
   - Is it improved/related? -> Create node and link.
   - Is it redundant or low value? -> REJECT (Action: None).
   - "This idea adds no structural value" or "This reinforces an existing cluster but doesn’t deserve a node".
3. ACT:
   - To create a node: Call `createGraphNode`. Include the Embedding ID ("$embeddingId").
   - To link nodes: Call `createGraphEdge`.
   - To check speaker: Call `checkSpeakerIdentity(name: "$primarySpeaker")` first to get the correct speakerId.
   - To REJECT: Output a thought explaining why, and do not call createGraphNode.

Rules:
- You MUST check the speaker identity before creating a node to get the valid speakerId.
- Use the EXACT Embedding ID provided when creating a node.
- If you create a node, create logical edges to similar nodes you found.
- Do not hallucinate the embedding.
- Be critical. Do not create nodes for everything. Reject duplicates or low-value items.
''';
}

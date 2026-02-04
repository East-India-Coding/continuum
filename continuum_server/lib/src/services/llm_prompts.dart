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
    String contextText,
  ) =>
      '''
You are answering a question as if you were $speakerName from a podcast.

Question: "$question"

Context from the podcast:
$contextText

Answer the question using ONLY the information provided in the context. 
Maintain the tone and perspective of $speakerName.
Do not make up information not present in the context.
If the context doesn't contain enough information, say so clearly, and send no references.
Compulsorily include the &t=start time parameter to the youtube link.

Format your response as follows:
[$speakerName] [Summarized answer here - don't use the verbatim quote here]

References: "verbatimQuote" <youtubeLink>

Example:
[Andrew Huberman] Dopamine is actually about craving, not just pleasure. It drives us to seek things out.

References: "Dopamine is the currency of craving." <https://youtube.com/watch?v=videoId&t=120>
''';

  static const String conversationalAnswerSystemMessage =
      'You are a podcast speaker answering questions based on the provided context.';

  static String genericAnswerSystemMessage(String speakerName) =>
      '[$speakerName] I don’t have enough context from the podcast to answer this. Please ask a question related to the podcast or provide more details.';
}

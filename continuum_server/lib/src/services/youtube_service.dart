import 'dart:developer';

import 'package:continuum_server/src/generated/protocol.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'dart:convert';
import 'dart:io';
import 'package:youtube_transcript_api/youtube_transcript_api.dart';

class YouTubeService {
  Future<File?> getCaptions(Session session, String videoId) async {
    try {
      final tempDir = Directory.systemTemp;
      final file = File('${tempDir.path}/$videoId.json');

      final api = YouTubeTranscriptApi();
      final transcript = await api.fetch(
        videoId,
        languages: ['en', 'en-US', 'en-GB'],
      );

      final jsonFormatter = JsonFormatter();
      final jsonContent = jsonFormatter.format(transcript);
      session.log('YouTubeService: Captions fetched for video: $videoId');

      await file.writeAsString(jsonContent);

      return file;
    } catch (e, stackTrace) {
      session.log(
        'Error fetching captions: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Extracts video ID from various YouTube URL formats
  String? extractVideoId(String url) {
    final regExp = RegExp(
      r'^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*',
    );

    final match = regExp.firstMatch(url);
    if (match == null) return null;

    final videoId = match.group(2);
    if (videoId != null && videoId.length == 11) {
      return videoId;
    }

    return null;
  }

  /// Retrieves video metadata (title, channel, thumbnail)
  Future<VideoMetadata?> getVideoMetadata(String youtubeUrl) async {
    try {
      final videoId = extractVideoId(youtubeUrl);
      if (videoId == null) {
        throw Exception('Invalid YouTube URL');
      }

      // Use YouTube oEmbed API to get metadata
      final oembedUrl =
          'https://www.youtube.com/oembed?url=$youtubeUrl&format=json';

      final response = await http.get(Uri.parse(oembedUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return VideoMetadata(
          youtubeUrl: youtubeUrl,
          videoId: videoId,
          title: data['title'],
          channelName: data['author_name'],
          thumbnailUrl: data['thumbnail_url'],
        );
      }
    } catch (e) {
      log('Error fetching metadata: $e');
    }

    return null;
  }
}

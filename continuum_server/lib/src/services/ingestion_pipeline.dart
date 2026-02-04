import 'dart:async';
import 'package:continuum_server/src/services/youtube_service.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'llm_service.dart';
import 'graph_service.dart';

/// Main pipeline orchestrator for processing podcasts
class IngestionPipeline {
  static Future<void> processPodcast(
    Session session,
    int jobId,
    String userId,
    int podcastId,
  ) async {
    session.log(
      'IngestionPipeline: processPodcast started for job $jobId, podcast $podcastId',
    );
    try {
      await _updateJobStatus(
        session,
        jobId,
        'processing',
        'Initializing ingestion',
        10,
      );

      final podcast = await Podcast.db.findById(session, podcastId);
      if (podcast == null) {
        session.log(
          'IngestionPipeline: Podcast $podcastId not found',
          level: LogLevel.error,
        );
        throw Exception('Podcast not found');
      }

      await _updateJobStatus(
        session,
        jobId,
        'processing',
        'Podcast verified',
        15,
      );

      final llmService = LLMService();

      SegmentedTranscript segmentedTranscript;
      final existingTranscript = await SegmentedTranscript.db.findFirstRow(
        session,
        where: (t) => t.videoId.equals(podcast.videoId),
      );

      await _updateJobStatus(
        session,
        jobId,
        'processing',
        'Checking transcript cache',
        20,
      );

      if (existingTranscript != null) {
        session.log(
          'IngestionPipeline: Found existing transcript for video ${podcast.videoId}',
        );
        segmentedTranscript = existingTranscript;
      } else {
        session.log(
          'IngestionPipeline: Fetching new segmented transcript for video ${podcast.videoId}',
        );
        await _updateJobStatus(
          session,
          jobId,
          'processing',
          'Generating transcript',
          25,
        );

        final ytService = YouTubeService();

        final captionsFile = await ytService.getCaptions(
          session,
          podcast.videoId,
        );

        await _updateJobStatus(
          session,
          jobId,
          'processing',
          'AI Agent processing',
          45,
        );

        // Start keep-alive timer to prevent stream timeout
        Timer? keepAliveTimer;
        try {
          keepAliveTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
            _updateJobStatus(
              session,
              jobId,
              'processing',
              'AI Agent processing',
              45 + (timer.tick),
            );
          });

          final fetchedTranscript = await llmService.getSegmentedTranscript(
            session,
            podcast,
            jobId,
            captionsFile,
          );
          segmentedTranscript = fetchedTranscript.copyWith(
            videoId: podcast.videoId,
          );
        } finally {
          keepAliveTimer?.cancel();
        }

        await _updateJobStatus(
          session,
          jobId,
          'processing',
          'AI generation completed',
          60,
        );

        // Store transcript for the user
        await SegmentedTranscript.db.insertRow(session, segmentedTranscript);
        session.log(
          'IngestionPipeline: Transcript inserted for video ${podcast.videoId}',
        );
        await _updateJobStatus(
          session,
          jobId,
          'processing',
          'Transcript stored',
          70,
        );
      }

      await _updateJobStatus(
        session,
        jobId,
        'processing',
        'Building knowledge graph',
        80,
      );

      final graphService = GraphService();

      // Node construction, link similar topics
      final nodeCount = await graphService.processTranscriptIdeas(
        session,
        userId,
        podcastId,
        podcast.videoId,
        segmentedTranscript.ideas,
      );

      if (nodeCount == 0) {
        session.log(
          'IngestionPipeline: No nodes created, throwing error',
          level: LogLevel.warning,
        );
        throw Exception('No nodes created for podcast');
      }

      // update podcast graphExists to true
      await Podcast.db.updateRow(
        session,
        podcast.copyWith(graphExists: true),
      );
      await _updateJobStatus(session, jobId, 'completed', 'Completed', 100);
    } catch (e, stackTrace) {
      session.log(
        'IngestionPipeline: Error processing podcast: $e',
        level: LogLevel.error,
        stackTrace: stackTrace,
      );
      await _updateJobStatus(
        session,
        jobId,
        'failed',
        'Error',
        0,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  static Future<void> _updateJobStatus(
    Session session,
    int jobId,
    String status,
    String stage,
    int progress, {
    String? errorMessage,
  }) async {
    final job = await IngestionJob.db.findById(session, jobId);
    if (job != null) {
      final updatedJob = await IngestionJob.db.updateRow(
        session,
        job.copyWith(
          status: status,
          stage: stage,
          progress: progress,
          errorMessage: errorMessage,
          updatedAt: DateTime.now(),
          completedAt: status == 'completed' || status == 'failed'
              ? DateTime.now()
              : null,
        ),
      );

      await session.messages.postMessage(
        'job-updates-$jobId',
        updatedJob,
      );
    }
  }
}

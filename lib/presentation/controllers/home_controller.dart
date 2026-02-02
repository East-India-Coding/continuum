// ignore_for_file: avoid_redundant_argument_values
import 'dart:async';

import 'package:continuum/domain/ingestion_job.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

class HomeState {
  const HomeState({
    this.ingestionJob,
    this.isSubmitting = false,
    this.errorMessage,
  });

  final IngestionJob? ingestionJob;
  final bool isSubmitting;
  final String? errorMessage;

  HomeState copyWith({
    IngestionJob? ingestionJob,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return HomeState(
      ingestionJob: ingestionJob ?? this.ingestionJob,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@riverpod
class HomeController extends _$HomeController {
  StreamSubscription<IngestionJob>? _statusSubscription;

  @override
  HomeState build() {
    ref.onDispose(() {
      unawaited(_statusSubscription?.cancel());
    });
    return const HomeState();
  }

  Future<void> generate(String url) async {
    if (url.isEmpty) {
      state = const HomeState(
        isSubmitting: false,
        errorMessage: 'Please enter a YouTube URL',
      );
      return;
    }

    state = const HomeState(
      isSubmitting: true,
      errorMessage: null,
    );

    try {
      // final podcastService = ref.read(podcastServiceProvider);
      // final job = await podcastService.ingest(url);

      // state = HomeState(
      //   ingestionJob: job,
      //   isSubmitting: false,
      //   errorMessage: null,
      // );

      // await _monitorJobStatus(job.id!);
    } catch (e) {
      state = HomeState(
        ingestionJob: state.ingestionJob,
        isSubmitting: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> _monitorJobStatus(int jobId) async {
    await _statusSubscription?.cancel();

    // final podcastService = ref.read(podcastServiceProvider);
    // _statusSubscription = podcastService
    //     .watchJob(jobId)
    //     .listen(
    //       (job) {
    //         if (job.status == 'failed') {
    //           state = HomeState(
    //             ingestionJob: job,
    //             isSubmitting: false,
    //             errorMessage: job.errorMessage,
    //           );
    //         } else {
    //           state = state.copyWith(ingestionJob: job);
    //         }
    //       },
    //       onError: (Object e) {
    //         state = HomeState(
    //           ingestionJob: state.ingestionJob,
    //           isSubmitting: false,
    //           errorMessage: e.toString(),
    //         );
    //       },
    //     );
  }

  void reset() {
    unawaited(_statusSubscription?.cancel());
    state = const HomeState();
  }
}

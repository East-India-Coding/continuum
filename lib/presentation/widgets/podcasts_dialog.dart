import 'dart:async';

import 'package:continuum/presentation/widgets/continuum_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:continuum/presentation/utils/url_launcher.dart';
import 'package:continuum/presentation/utils/continuum_colors.dart';

class PodcastsDialog extends ConsumerWidget {
  const PodcastsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final podcasts = ref.watch(listPodcastsProvider);

    return ContinuumDialog(
      title: 'Podcasts',
      child: Placeholder(),
      // child: podcasts.when(
      //   data: (podcasts) {
      //     if (podcasts.isEmpty) {
      //       return const Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Center(
      //             child: Text(
      //               'No podcasts found',
      //               style: TextStyle(color: ContinuumColors.accent),
      //             ),
      //           ),
      //         ],
      //       );
      //     }

      //     return ListView.builder(
      //       itemCount: podcasts.length,
      //       shrinkWrap: true,
      //       itemBuilder: (context, index) {
      //         final podcast = podcasts[index];
      //         return ListTile(
      //           title: Text(
      //             podcast.title ?? '',
      //             style: const TextStyle(fontSize: 14),
      //           ),
      //           subtitle: Text(
      //             podcast.channelName ?? '',
      //             style: const TextStyle(fontSize: 12),
      //           ),
      //           leading: Image.network(
      //             podcast.thumbnailUrl ?? '',
      //             width: 60,
      //             height: 60,
      //           ),
      //           onTap: () {
      //             unawaited(UrlLauncher.launchURLNewTab(podcast.youtubeUrl));
      //           },
      //         );
      //       },
      //     );
      //   },
      //   error: (error, stackTrace) => Text(error.toString()),
      //   loading: () => const CupertinoActivityIndicator(),
      // ),
    );
  }
}

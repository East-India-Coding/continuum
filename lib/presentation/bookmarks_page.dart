import 'package:continuum/domain/graph_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:continuum/presentation/utils/continuum_colors.dart';
import 'package:continuum/presentation/widgets/node_info_dialog.dart';

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final bookmarkedNodesValue = ref.watch(bookmarkedNodesProvider);

    return Scaffold(
      backgroundColor: ContinuumColors.primary,
      // body: bookmarkedNodesValue.when(
      //   data: (nodes) {
      //     if (nodes.isEmpty) {
      //       return const Center(
      //         child: Text(
      //           'No bookmarks yet',
      //           style: TextStyle(color: ContinuumColors.textGrey),
      //         ),
      //       );
      //     }

      //     return GridView.builder(
      //       padding: const EdgeInsets.all(16),
      //       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //         maxCrossAxisExtent: 400,
      //         mainAxisExtent: 280,
      //         crossAxisSpacing: 16,
      //         mainAxisSpacing: 16,
      //       ),
      //       itemCount: nodes.length,
      //       itemBuilder: (context, index) {
      //         final node = nodes[index];
      //         return _BookmarkCard(node: node);
      //       },
      //     );
      //   },
      //   loading: () => const Center(child: CupertinoActivityIndicator()),
      //   error: (error, stack) => Center(
      //     child: Text(
      //       error.toString(),
      //       style: const TextStyle(color: ContinuumColors.accent),
      //     ),
      //   ),
      // ),
    );
  }
}

// class _BookmarkCard extends StatelessWidget {
//   const _BookmarkCard({required this.node});

//   final GraphNode node;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: ContinuumColors.primaryDark,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: ContinuumColors.accentDark.withValues(alpha: 0.3),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: MouseRegion(
//         cursor: SystemMouseCursors.click,
//         child: GestureDetector(
//           onTap: () {
//             // Convert GraphNode to GraphNodeDisplay for the dialog
//             final displayNode = GraphNodeDisplay(
//               name: node.label,
//               nodeId: node.id!,
//               videoId: node.videoId,
//               summary: node.summary,
//               primarySpeakerId: node.primarySpeakerId,
//               references: node.references,
//               value: node.impactScore,
//               category: 0,
//               symbolSize: 10,
//               isBookmarked: node.isBookmarked,
//             );

//             showDialog<void>(
//               context: context,
//               builder: (context) => NodeInfoDialog(node: displayNode),
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Node ID Pill
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: ContinuumColors.accentDarker,
//                     borderRadius: BorderRadius.circular(4),
//                     border: Border.all(
//                       color: ContinuumColors.accentDark,
//                       width: 0.5,
//                     ),
//                   ),
//                   child: Text(
//                     'NODE ID: ${(node.id ?? 0).toString().padLeft(3, '0')}',
//                     style: const TextStyle(
//                       color: ContinuumColors.accent,
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Title
//                 Text(
//                   node.label,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     fontStyle: FontStyle.italic,
//                     height: 1.1,
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 const Row(
//                   children: [
//                     Icon(
//                       Icons.play_circle_fill,
//                       color: ContinuumColors.accent,
//                       size: 14,
//                     ),
//                     SizedBox(width: 6),
//                     Expanded(
//                       child: Text(
//                         'PODCAST SOURCE',
//                         style: TextStyle(
//                           color: ContinuumColors.accentDark,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 16),

//                 // AI Summary
//                 Expanded(
//                   child: Text(
//                     'Summary: ${node.summary}',
//                     maxLines: 4,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: ContinuumColors.textGrey,
//                       fontSize: 13,
//                       height: 1.5,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 12),

//                 // Footer
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         _Dot(),
//                         const SizedBox(width: 4),
//                         _Dot(),
//                         const SizedBox(width: 4),
//                         _Dot(),
//                       ],
//                     ),
//                     const Text(
//                       'EXPAND FRAGMENT',
//                       style: TextStyle(
//                         color: ContinuumColors.accent,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: ContinuumColors.accentDark,
        shape: BoxShape.circle,
      ),
    );
  }
}

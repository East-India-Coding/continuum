import 'package:flutter/material.dart';
import 'package:continuum_client/continuum_client.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';

class SpeakerChecklist extends StatelessWidget {
  const SpeakerChecklist({
    required this.speakers,
    required this.selectedSpeakerIds,
    required this.onToggle,
    super.key,
  });

  final List<Speaker> speakers;
  final Set<int> selectedSpeakerIds;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    if (speakers.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FILTER BY SPEAKER',
            style: TextStyle(
              color: ContinuumColors.accent,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: speakers.map((speaker) {
                final isSelected = selectedSpeakerIds.contains(speaker.id);
                return InkWell(
                  onTap: () => onToggle(speaker.id!),
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 4,
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ContinuumColors.accent
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: isSelected
                                  ? ContinuumColors.accent
                                  : Colors.grey[700]!,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.black,
                                )
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          speaker.name,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[400],
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

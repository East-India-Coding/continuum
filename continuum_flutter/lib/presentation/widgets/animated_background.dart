import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({
    required this.child,
    this.gradientColors,
    this.frequency = 1,
    this.speed = 1,
    this.amplitude = 10,
    this.grain = 0.2,
    super.key,
  });

  final List<Color>? gradientColors;
  final Widget child;
  final double frequency;
  final double speed;
  final double amplitude;
  final double grain;

  @override
  Widget build(BuildContext context) {
    return AnimatedMeshGradient(
      colors:
          gradientColors ??
          [
            ContinuumColors.primary,
            ContinuumColors.primary,
            ContinuumColors.accentDarker,
            ContinuumColors.accentDark,
          ],
      options: AnimatedMeshGradientOptions(
        frequency: frequency,
        speed: speed,
        amplitude: amplitude,
        grain: grain,
      ),
      child: child,
    );
  }
}

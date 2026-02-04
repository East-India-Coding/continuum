import 'dart:ui' show Color;

extension ColorExtension on Color {
  String get toRGBA {
    // ignore: deprecated_member_use
    return 'rgba(${(red * 255).toInt()}, ${(green * 255).toInt()}, ${(blue * 255).toInt()}, $opacity)';
  }
}

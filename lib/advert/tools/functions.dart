import 'dart:ui';

Color invert(Color color) {
  return Color.from(
    alpha: color.a * 255,
    red: 1.0 - color.r,
    green: 1.0 - color.g,
    blue: 1.0 - color.b,
  );
}

Color generateColor(String uuid) {
  int hash = 0;
  for (int i = 0; i < uuid.length; i++) {
    hash = 20 * hash + uuid.codeUnitAt(i);
  }
  Color color = Color(hash & 0xFFFFFF).withValues(alpha: 1.0);
  double luminance = color.computeLuminance();
  return luminance < 0.5 ? color : invert(color);
}

import 'dart:ui';

Color invert(Color color) {
  return Color.fromARGB(
    color.alpha,
    255 - color.red,
    255 - color.green,
    255 - color.blue,
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

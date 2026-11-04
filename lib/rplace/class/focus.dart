class PixelFocus {
  late final int x;
  late final int y;
  late final bool isFocus;

  PixelFocus({
    required this.x,
    required this.y,
    required this.isFocus,
  });

  static PixelFocus empty() {
    return PixelFocus(
      x: 0,
      y: 0,
      isFocus: false,
    );
  }

  @override
  String toString() => 'Focus(pos: ($x, $y), isFocus: $isFocus)';
}

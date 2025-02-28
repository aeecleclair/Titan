class PixelFocus {
  late final int x;
  late final int y;
  late final String? user;
  late final DateTime? date;
  late final bool isFocus;

  PixelFocus({
    required this.x,
    required this.y,
    required this.user,
    required this.date,
    required this.isFocus,
  });

  static PixelFocus empty() {
    return PixelFocus(
      x: 0,
      y: 0,
      user: null,
      date: null,
      isFocus: false,
    );
  }

  @override
  String toString() =>
      'Focus(pos: ($x, $y), user: $user, date: $date, isFocus: $isFocus)';
}

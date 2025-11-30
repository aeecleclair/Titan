class Pixel {
  late final int x;
  late final int y;
  late final String color;

  Pixel({
    required this.x,
    required this.y,
    required this.color,
  });

  Pixel.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    data['color'] = color;
    return data;
  }

  @override
  String toString() => 'Pixel(offset: ($x, $y), color: $color)';
}

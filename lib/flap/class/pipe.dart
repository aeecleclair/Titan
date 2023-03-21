import 'dart:math';

class Pipe {
  final double position;
  final double height;

  Pipe({required this.position, required this.height});

  Pipe copyWith({double? position, double? height}) {
    return Pipe(
      position: position ?? this.position,
      height: height ?? this.height,
    );
  }

  static Pipe empty() {
    return Pipe(position: 0, height: 0);
  }

  static Pipe random({required double position}) {
    final random = Random();
    final randomHeight = random.nextInt(300).toDouble() + 50;
    return Pipe(
      position: position,
      height: randomHeight,
    );
  }
}

import 'dart:math';

class Pipe {
  final double position;
  final double height;
  final bool isPassed;

  Pipe({required this.position, required this.height, this.isPassed = false});

  Pipe copyWith({double? position, double? height, bool? isPassed}) {
    return Pipe(
      position: position ?? this.position,
      height: height ?? this.height,
      isPassed: isPassed ?? this.isPassed,
    );
  }

  static Pipe empty() {
    return Pipe(position: 0, height: 0, isPassed: false);
  }

  static Pipe random({required double position}) {
    final random = Random();
    final randomHeight = random.nextInt(300).toDouble() + 50;
    return Pipe(position: position, height: randomHeight);
  }

  @override
  String toString() {
    return 'Pipe{position: $position, height: $height, isPassed: $isPassed}';
  }
}

import 'package:flutter/material.dart';
import 'package:titan/chooser/class/finger.dart';

class FingerDot extends StatelessWidget {
  const FingerDot({super.key, required this.finger});
  final Finger finger;

  @override
  Widget build(BuildContext context) {
    final size = finger.isSelected ? 85.0 : 55.0;

    // Même équipe → même couleur (via teamIndex). Sinon couleur perso du doigt.
    Color baseColor;
    if (finger.teamIndex != null) {
      final idx = (finger.teamIndex! - 1).clamp(0, Colors.primaries.length - 1);
      baseColor = Colors.primaries[idx];
    } else {
      baseColor = finger.color;
    }

    return Positioned(
      left: finger.position.dx - size / 2,
      top: finger.position.dy - size / 2,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size * 1.5,
        height: size * 1.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: baseColor.withOpacity(.35),
          border: Border.all(
            color: baseColor,
            width: finger.isSelected ? 6 : 3,
          ),
        ),
        child: Center(
          child: finger.teamIndex != null
              ? Text(
                  '${finger.teamIndex}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

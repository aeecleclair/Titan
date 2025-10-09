import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class MainCardButton extends StatelessWidget {
  final HeroIcons icon;
  final String title;
  final Future<dynamic> Function() onPressed;
  final List<Color> colors;
  const MainCardButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.title,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        WaitingButton(
          onTap: onPressed,
          builder: (child) => Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: colors,
                center: Alignment.topLeft,
                radius: 1.5,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: colors.last.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: child,
          ),
          child: HeroIcon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            color: colors.first,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

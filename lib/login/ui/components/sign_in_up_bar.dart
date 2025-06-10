import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/ui/widgets/loader.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class SignInUpBar extends StatelessWidget {
  const SignInUpBar({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isLoading,
    this.color = Colors.white,
    this.icon = const HeroIcon(
      HeroIcons.arrowRight,
      color: Colors.white,
      size: 35.0,
    ),
  });

  final String label;
  final Future Function() onPressed;
  final bool isLoading;
  final Color color;
  final HeroIcon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: color == Colors.white
            ? Alignment.centerLeft
            : Alignment.center,
        child: WaitingButton(
          onTap: onPressed,
          builder: (child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              child,
            ],
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: isLoading ? Loader(color: color) : icon,
          ),
        ),
      ),
    );
  }
}

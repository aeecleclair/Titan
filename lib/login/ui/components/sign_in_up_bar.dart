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
    required this.color,
    required this.icon,
  });

  final String label;
  final Future Function() onPressed;
  final bool isLoading;
  final Color color;
  final HeroIcon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: 10),
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: .center,
        child: WaitingButton(
          onTap: onPressed,
          builder: (child) => Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 24, fontWeight: .w800, color: color),
              ),
              child,
            ],
          ),
          child: Container(
            margin: const .only(left: 20),
            child: isLoading ? Loader(color: color) : icon,
          ),
        ),
      ),
    );
  }
}

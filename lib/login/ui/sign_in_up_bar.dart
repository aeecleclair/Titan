import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class SignInUpBar extends StatelessWidget {
  const SignInUpBar({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.isLoading,
    this.color = Colors.white,
    this.icon = const HeroIcon(
      HeroIcons.arrowRight,
      color: Colors.white,
      size: 35.0,
    ),
  }) : super(key: key);

  final String label;
  final Future Function() onPressed;
  final bool isLoading;
  final Color color;
  final HeroIcon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ShrinkButton(
              onTap: onPressed,
              waitChild: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: color),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: CircularProgressIndicator(
                        color: color,
                      )),
                ],
              ),
              child: Row(
                mainAxisAlignment: color == Colors.white
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: color),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: color,
                          )
                        : icon,
                  ),
                ],
              ),
            )));
  }
}

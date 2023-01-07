import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class SignUpBar extends StatelessWidget {
  const SignUpBar({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.isLoading,
  }) : super(key: key);

  final String label;
  final Future Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: ShrinkButton(
              onTap: onPressed,
              child: Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: ColorConstants.background2),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: ColorConstants.gradient2,
                          )
                        : const HeroIcon(
                            HeroIcons.arrowRight,
                            color: Colors.white,
                            size: 35.0,
                          ),
                  ),
                ],
              ),
            )));
  }
}

class SignInBar extends StatelessWidget {
  const SignInBar(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.isLoading})
      : super(key: key);

  final String label;
  final Future Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ShrinkButton(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.background2),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: ColorConstants.gradient2,
                    )
                  : const HeroIcon(
                      HeroIcons.arrowRight,
                      color: ColorConstants.gradient2,
                      size: 35.0,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

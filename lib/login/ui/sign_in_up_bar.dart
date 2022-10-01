import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myecl/login/tools/constants.dart';

class SignUpBar extends StatelessWidget {
  const SignUpBar({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.isLoading,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onPressed,
              child: Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Icon(
                            FontAwesomeIcons.rightLong,
                            color: Colors.white,
                            size: 24.0,
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
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          height: 50,
          child: GestureDetector(
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: LoginColorConstants.background),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: LoginColorConstants.gradient2,
                        )
                      : const Icon(
                          FontAwesomeIcons.rightLong,
                          color: LoginColorConstants.gradient2,
                          size: 24.0,
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}

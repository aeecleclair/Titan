import 'package:flutter/material.dart';
import 'package:myecl/tombola/tools/constants.dart';

class PersoButton extends StatelessWidget {
  const PersoButton({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(125, 3, 2, 69),
              blurRadius: 8,
              blurStyle: BlurStyle.outer,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              TombolaColorConstants.lightGradientBlueButton,
              TombolaColorConstants.darkGradientBlueButton,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, color: TombolaColorConstants.writtenWhite),
      ),
    );
  }
}

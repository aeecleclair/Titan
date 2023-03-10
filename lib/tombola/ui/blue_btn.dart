import 'package:flutter/material.dart';
import 'package:myecl/tombola/tools/constants.dart';

class BlueBtn extends StatelessWidget {
  final String text;

  const BlueBtn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          TombolaColorConstants.gradient1,
          TombolaColorConstants.gradient2
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(
              color: TombolaColorConstants.gradient2.withOpacity(0.4),
              offset: const Offset(2, 3),
              blurRadius: 5)
        ],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Colors.white,
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: TombolaColorConstants.gradient2),
        ),
      ),
    );
  }
}

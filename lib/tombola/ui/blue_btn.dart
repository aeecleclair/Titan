import 'package:flutter/material.dart';
import 'package:myecl/tombola/tools/constants.dart';

class BlueBtn extends StatelessWidget {
  final String text;

  const BlueBtn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
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
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}

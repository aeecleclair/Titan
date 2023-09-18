import 'package:flutter/material.dart';
import 'package:myecl/tools/constants.dart';

class AdminButton extends StatelessWidget {
  final Widget child;
  const AdminButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [ColorConstants.gradient1, ColorConstants.gradient2]),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.gradient2.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(2, 2),
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}

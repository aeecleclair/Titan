import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

class SuperAdminButton extends StatelessWidget {
  final Widget child;
  const SuperAdminButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ColorConstants.main, ColorConstants.onMain],
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.main.withValues(alpha: 0.5),
            blurRadius: 5,
            offset: const Offset(2, 2),
            spreadRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}

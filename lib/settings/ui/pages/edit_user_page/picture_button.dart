import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/constants.dart';

class PictureButton extends StatelessWidget {
  final HeroIcons icon;
  const PictureButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [
            ColorConstants.gradient1,
            ColorConstants.gradient2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.gradient2.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: HeroIcon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

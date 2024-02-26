import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class DeleteButton extends StatelessWidget {
  final Future Function() onDelete;

  const DeleteButton({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return WaitingButton(
      builder: (child) => Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
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
                color: ColorConstants.gradient2.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(2, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: child),
      onTap: onDelete,
      child: const HeroIcon(
        HeroIcons.xMark,
        color: Colors.white,
      ),
    );
  }
}

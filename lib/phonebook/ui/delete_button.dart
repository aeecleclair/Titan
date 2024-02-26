import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class DeleteButton extends StatelessWidget {
  final Future Function() onDelete;

  const DeleteButton({Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShrinkButton(
        waitChild: Container(
          padding: const EdgeInsets.all(10),
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
                color: ColorConstants.gradient2.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(2, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
        onTap: onDelete,
        child: Container(
          padding: const EdgeInsets.all(10),
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
                color: ColorConstants.gradient2.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(2, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const HeroIcon(
            HeroIcons.xMark,
            color: Colors.white,
          ),
        ));
  }
}

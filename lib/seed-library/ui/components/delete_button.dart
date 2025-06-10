import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/constants.dart';

class DeleteButton extends StatelessWidget {
  final void Function() onDelete;
  final bool deactivated;
  final bool deletion;

  const DeleteButton({
    super.key,
    required this.onDelete,
    required this.deactivated,
    required this.deletion,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !deactivated ? onDelete : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: !deactivated
                ? [ColorConstants.gradient1, ColorConstants.gradient2]
                : [ColorConstants.deactivated1, ColorConstants.deactivated2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: !deactivated
                  ? ColorConstants.gradient2.withValues(alpha: 0.2)
                  : ColorConstants.deactivated2.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(2, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: HeroIcon(
          deletion ? HeroIcons.trash : HeroIcons.noSymbol,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}

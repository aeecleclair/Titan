import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

class SpecialActionButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final Widget icon;
  const SpecialActionButton({
    super.key,
    required this.name,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorConstants.onTertiary, width: 2),
                color: ColorConstants.tertiary,
              ),
              child: Center(child: icon),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 55,
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: ColorConstants.onTertiary,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

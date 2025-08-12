import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

class AnnouncerItem extends StatelessWidget {
  final String name, avatarName;
  final bool selected;
  final VoidCallback onTap;
  const AnnouncerItem({
    super.key,
    required this.name,
    required this.onTap,
    required this.selected,
    required this.avatarName,
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
                border: selected
                    ? Border.all(color: ColorConstants.tertiary, width: 3)
                    : null,
                color: Colors.grey.shade100,
              ),
              child: Center(
                child: Text(
                  avatarName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: selected
                        ? ColorConstants.onTertiary
                        : ColorConstants.tertiary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 55,
              child: AutoSizeText(
                name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: selected
                      ? ColorConstants.onTertiary
                      : ColorConstants.tertiary,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/constants.dart';

class ListItemTemplate extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? icon;
  final Function()? onTap;
  final Widget? trailing;

  const ListItemTemplate({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 10)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.tertiary,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.onTertiary,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            if (trailing != null)
              trailing!
            else
              const HeroIcon(
                HeroIcons.chevronRight,
                color: ColorConstants.tertiary,
              ),
          ],
        ),
      ),
    );
  }
}

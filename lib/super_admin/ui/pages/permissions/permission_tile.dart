import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/constants.dart';

class PermissionTile extends StatelessWidget {
  final String title;
  final int authorizedAccountTypes;
  final int totalAccountTypes;
  final int authorizedGroups;
  final int totalGroups;
  final VoidCallback onTap;

  const PermissionTile({
    super.key,
    required this.title,
    required this.authorizedAccountTypes,
    required this.totalAccountTypes,
    required this.authorizedGroups,
    required this.totalGroups,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: ColorConstants.background,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.onTertiary.withAlpha(20),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.title,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _SummaryChip(
                        icon: HeroIcons.userCircle,
                        label: '$authorizedAccountTypes/$totalAccountTypes',
                      ),
                      const SizedBox(width: 8),
                      _SummaryChip(
                        icon: HeroIcons.userGroup,
                        label: '$authorizedGroups/$totalGroups',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const HeroIcon(
              HeroIcons.chevronRight,
              color: ColorConstants.secondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final HeroIcons icon;
  final String label;

  const _SummaryChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: ColorConstants.onBackground.withAlpha(40),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeroIcon(icon, size: 14, color: ColorConstants.tertiary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ColorConstants.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}

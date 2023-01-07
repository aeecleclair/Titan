import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class SettingsItem extends StatelessWidget {
  final Widget child;
  final HeroIcons icon;
  final void Function() onTap;

  const SettingsItem({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: HeroIcon(icon,
                size: 30, color: Theme.of(context).colorScheme.tertiary),
          ),
          Expanded(child: child),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border:
                    Border.all(color: Theme.of(context).colorScheme.tertiary),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(2, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10)),
            child: HeroIcon(
              HeroIcons.chevronRight,
              size: 25,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}

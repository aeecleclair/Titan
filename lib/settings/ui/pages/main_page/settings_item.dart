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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: HeroIcon(
            icon,
            size: 30,
            color: Colors.black,
          ),
        ),
        Expanded(child: child),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: const HeroIcon(
              HeroIcons.chevronRight,
              size: 25,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

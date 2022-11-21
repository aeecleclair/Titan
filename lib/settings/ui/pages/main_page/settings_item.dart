import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class SettingsItem extends StatelessWidget {
  final Widget child;
  final Widget icon;
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
            child: icon
          ),
          Expanded(child: child),
          Container(
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
        ],
      ),
    );
  }
}

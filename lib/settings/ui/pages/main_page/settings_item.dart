import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/constants.dart';

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
            child: HeroIcon(
              icon,
              size: 30,
              color: Colors.black,
            ),
          ),
          Expanded(child: child),
          Container(
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
                    offset: const Offset(1, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(10)),
            child: const HeroIcon(
              HeroIcons.chevronRight,
              size: 25,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

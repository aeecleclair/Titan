import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? icon;
  final Function()? onTap;

  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListItemTemplate(
      onTap: onTap,
      title: title,
      subtitle: subtitle,
      icon: icon,
      trailing: onTap != null
          ? HeroIcon(HeroIcons.chevronRight, color: ColorConstants.tertiary)
          : SizedBox.shrink(),
    );
  }
}

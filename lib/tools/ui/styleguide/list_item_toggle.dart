import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';

class ToggleListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? icon;
  final Function()? onTap;
  final bool selected;

  const ToggleListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListItemTemplate(
      onTap: onTap,
      title: title,
      subtitle: subtitle,
      icon: icon,
      trailing: selected
          ? CustomIconButton(
              type: CustomIconButtonType.main,
              icon: const HeroIcon(
                HeroIcons.minus,
                color: ColorConstants.background,
              ),
              onPressed: onTap ?? () {},
            )
          : CustomIconButton.secondary(
              icon: const HeroIcon(
                HeroIcons.plus,
                color: ColorConstants.tertiary,
              ),
              onPressed: onTap ?? () {},
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/constants.dart';

class CustomSearchBar extends HookWidget {
  final String hintText;
  final Function() onFilter;
  final Function(String) onSearch;
  final bool autofocus;
  const CustomSearchBar({
    super.key,
    this.hintText = 'Rechercher',
    required this.onFilter,
    required this.onSearch,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ColorConstants.searchBar,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Row(
          children: [
            HeroIcon(
              HeroIcons.magnifyingGlass,
              color: ColorConstants.onBackground,
              size: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: textController,
                autofocus: autofocus,
                onChanged: (value) {
                  onSearch(value);
                },
                style: TextStyle(
                  color: ColorConstants.onBackground,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: ColorConstants.secondary,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            if (textController.text.isNotEmpty)
              IconButton(
                icon: HeroIcon(
                  HeroIcons.xMark,
                  color: ColorConstants.onBackground,
                  size: 20,
                ),
                onPressed: () {
                  textController.clear();
                },
                splashRadius: 20,
              ),
            IconButton(
              icon: HeroIcon(
                HeroIcons.adjustmentsHorizontal,
                color: ColorConstants.onBackground,
                size: 20,
              ),
              onPressed: onFilter,
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}

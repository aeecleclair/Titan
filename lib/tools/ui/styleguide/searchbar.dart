import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';

class CustomSearchBar extends HookWidget {
  final String? hintText;
  final Function()? onFilter;
  final Function(String) onSearch;
  final bool autofocus;
  const CustomSearchBar({
    super.key,
    this.hintText,
    this.onFilter,
    required this.onSearch,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final focusNode = useFocusNode();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ColorConstants.background,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.onTertiary.withAlpha(30),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (textController.text.isEmpty) {
                  focusNode.requestFocus();
                } else {
                  onSearch(textController.text);
                }
              },
              child: HeroIcon(
                HeroIcons.magnifyingGlass,
                color: ColorConstants.tertiary,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: textController,
                focusNode: focusNode,
                autofocus: autofocus,
                onChanged: (value) {
                  onSearch(value);
                },
                style: TextStyle(color: ColorConstants.tertiary, fontSize: 16),
                cursorColor: ColorConstants.tertiary,
                decoration: InputDecoration(
                  hintText:
                      hintText ??
                      AppLocalizations.of(context)!.phonebookPhonebookSearch,
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
                  color: ColorConstants.tertiary,
                  size: 20,
                ),
                onPressed: () {
                  textController.clear();
                },
                splashRadius: 20,
              ),
            if (onFilter != null)
              IconButton(
                icon: HeroIcon(
                  HeroIcons.adjustmentsHorizontal,
                  color: ColorConstants.tertiary,
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

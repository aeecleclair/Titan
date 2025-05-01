import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/tools/functions.dart';
import 'package:myecl/tools/providers/theme_provider.dart';

class TagChip extends ConsumerWidget {
  final String tagName;
  const TagChip({super.key, required this.tagName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    Color bgColor = generateColor(tagName);
    Color borderColor = isDarkTheme
        ? (bgColor.computeLuminance() < 0.1
            ? Theme.of(context).colorScheme.onPrimary
            : bgColor)
        : (bgColor.computeLuminance() > 0.9
            ? Theme.of(context).colorScheme.onPrimary
            : bgColor);
    Color secondaryBgColor = isDarkTheme
        ? Color.from(
            alpha: bgColor.a,
            red: min(bgColor.r + 0.12, 1), // 0.12 = 30/255
            green: min(bgColor.g + 0.12, 1),
            blue: min(bgColor.b + 0.12, 1),
          )
        : Color.from(
            alpha: bgColor.a,
            red: max(bgColor.r - 0.12, 0), // 0.12 = 30/255
            green: max(bgColor.g - 0.12, 0),
            blue: max(bgColor.b - 0.12, 0),
          );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            bgColor,
            secondaryBgColor,
          ],
          stops: const [0.7, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          tagName,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            color:
                bgColor.computeLuminance() < 0.75 ? Colors.white : Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

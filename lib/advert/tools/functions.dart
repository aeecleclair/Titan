
import 'package:flutter/material.dart';
import 'package:titan/l10n/app_localizations.dart';

Color invert(Color color) {
  return Color.from(
    alpha: color.a * 255,
    red: 1.0 - color.r,
    green: 1.0 - color.g,
    blue: 1.0 - color.b,
  );
}

Color generateColor(String uuid) {
  int hash = 0;
  for (int i = 0; i < uuid.length; i++) {
    hash = 20 * hash + uuid.codeUnitAt(i);
  }
  Color color = Color(hash & 0xFFFFFF).withValues(alpha: 1.0);
  double luminance = color.computeLuminance();
  return luminance < 0.5 ? color : invert(color);
}

List<String> getLocalizedMonths(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return [
    l10n.advertMonthJan,
    l10n.advertMonthFeb,
    l10n.advertMonthMar,
    l10n.advertMonthApr,
    l10n.advertMonthMay,
    l10n.advertMonthJun,
    l10n.advertMonthJul,
    l10n.advertMonthAug,
    l10n.advertMonthSep,
    l10n.advertMonthOct,
    l10n.advertMonthNov,
    l10n.advertMonthDec,
  ];
}

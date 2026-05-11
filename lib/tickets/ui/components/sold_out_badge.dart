import 'package:flutter/material.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';

class SoldOutBadge extends StatelessWidget {
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final String? label;

  const SoldOutBadge({
    super.key,
    this.fontSize = 11,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final text = label ?? AppLocalizations.of(context)!.ticketsSoldOut;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: ColorConstants.error.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: ColorConstants.error,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:titan/l10n/app_localizations.dart';

class ReadOnlyBanner extends StatelessWidget {
  /// Optional custom message. Defaults to [ticketsReadOnlyDueSales].
  final String? message;

  const ReadOnlyBanner({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message ?? l10n.ticketsReadOnlyDueSales,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
      ),
    );
  }
}

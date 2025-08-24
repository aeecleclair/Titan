import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/ph/class/ph.dart';
import 'package:titan/ph/tools/functions.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/l10n/app_localizations.dart';

class AdminPhCard extends StatelessWidget {
  final VoidCallback onEdit, onDelete;
  final Ph ph;
  const AdminPhCard({
    super.key,
    required this.ph,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return GestureDetector(
      onTap: () {},
      child: CardLayout(
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.phNameField,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(shortenText(ph.name, 28)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.phDateField,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(shortenText(phFormatDate(ph.date, locale), 28)),
                  ],
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: onEdit,
              child: CardButton(
                colors: [Colors.grey.shade100, Colors.grey.shade400],
                shadowColor: Colors.grey.shade300.withValues(alpha: 0.2),
                child: const HeroIcon(HeroIcons.pencil, color: Colors.black),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onDelete,
              child: CardButton(
                colors: const [Color(0xFF9E131F), Color(0xFF590512)],
                shadowColor: const Color(0xFF590512).withValues(alpha: 0.2),
                child: const HeroIcon(HeroIcons.trash, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

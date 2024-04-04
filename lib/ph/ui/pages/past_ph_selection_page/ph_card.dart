import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhCard extends HookConsumerWidget {
  final Ph ph;
  final VoidCallback onDownload;
  const PhCard({
    super.key,
    required this.ph,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phNotifier = ref.watch(phProvider.notifier);
    return GestureDetector(
      onTap: () {
        phNotifier.setPh(ph);
        QR.to(PhRouter.root + PhRouter.past_ph_selection + PhRouter.view_ph);
      },
      child: CardLayout(
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Nom : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(shortenText(ph.name, 28)),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Date de publication : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(phFormatDate(ph.date)),
                  ],
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: onDownload,
              child: CardButton(
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade400,
                ],
                shadowColor: Colors.grey.shade300.withOpacity(0.2),
                child: const HeroIcon(HeroIcons.arrowDownTray,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

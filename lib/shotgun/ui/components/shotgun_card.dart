import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/providers/selected_shotgun_provider.dart';
import 'package:titan/shotgun/router.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

class ShotgunCard extends ConsumerWidget {
  final Shotgun shotgun;
  const ShotgunCard({super.key, required this.shotgun});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm');

    return ListItem(
      title: shotgun.name,
      subtitle: '${l10n.shotgunOpeningLabel}: ${dateFormatter.format(shotgun.openDatetime)}',
      onTap: () => showCustomBottomModal(
        context: context,
        modal: BottomModalTemplate(
          title: shotgun.name,
          child: Column(
            children: [
              Button(
                text: l10n.shotgunViewResults,
                onPressed: () {
                  ref.read(selectedShotgunProvider.notifier).state = shotgun;
                  QR.to(ShotgunRouter.root + ShotgunRouter.results);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 10),
              Button(
                text: l10n.shotgunEditTitle,
                onPressed: () {
                  ref.read(selectedShotgunProvider.notifier).state = shotgun;
                  QR.to(ShotgunRouter.root + ShotgunRouter.edit);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        ref: ref,
      ),
    );
  }
}

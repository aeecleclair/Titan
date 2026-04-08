import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/providers/selected_shotgun_provider.dart';
import 'package:titan/shotgun/router.dart';
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
      onTap: () {
        // Stocker le shotgun sélectionné et naviguer vers la page d'édition
        ref.read(selectedShotgunProvider.notifier).state = shotgun;
        QR.to(ShotgunRouter.root + ShotgunRouter.edit);
      },
    );
  }
}

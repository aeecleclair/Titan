import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/providers/selected_shotgun_provider.dart';
import 'package:titan/shotgun/repositories/shotgun_repository.dart';
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
      subtitle:
          '${l10n.shotgunOpeningLabel}: ${dateFormatter.format(shotgun.openDatetime)}',
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
                onPressed: () async {
                  // Charger les détails complets avant d'éditer
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  try {
                    final token = ref.read(tokenProvider);
                    final repository = ShotgunRepository()..setToken(token);
                    final detailedShotgun = await repository.getShotgunById(shotgun.id);

                    if (context.mounted) {
                      Navigator.of(context).pop(); // Ferme le loader
                      ref.read(selectedShotgunProvider.notifier).state = detailedShotgun;
                      QR.to(ShotgunRouter.root + ShotgunRouter.edit);
                      Navigator.of(context).pop(); // Ferme le modal
                    }
                  } catch (e) {
                    if (context.mounted) {
                      Navigator.of(context).pop(); // Ferme le loader
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erreur: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
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

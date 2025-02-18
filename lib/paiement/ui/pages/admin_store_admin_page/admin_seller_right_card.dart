import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/seller.dart';
import 'package:myecl/paiement/providers/store_admin_list_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';

class AdminSellerRightCard extends ConsumerWidget {
  final Seller storeSeller;
  const AdminSellerRightCard({super.key, required this.storeSeller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeAdminListNotifier = ref.watch(storeAdminListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              storeSeller.user.getName(),
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 29, 29),
                fontSize: 14,
              ),
            ),
          ),
          const Spacer(),
          WaitingButton(
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialogBox(
                  descriptions:
                      "Voulez-vous vraiment supprimer cet administrateur?",
                  title: "Supprimer l'administrateur",
                  onYes: () async {
                    await tokenExpireWrapper(ref, () async {
                      final value = await storeAdminListNotifier
                          .createStoreAdmin(storeSeller);
                      if (value) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          "Administrateur supprimé avec succès",
                        );
                      } else {
                        displayToastWithContext(
                          TypeMsg.msg,
                          "Erreur lors de la suppression de l'administrateur",
                        );
                      }
                    });
                  },
                ),
              );
            },
            builder: (child) => CardButton(
              size: 35,
              child: child,
            ),
            child: const HeroIcon(
              HeroIcons.trash,
              color: Color(0xFF590512),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

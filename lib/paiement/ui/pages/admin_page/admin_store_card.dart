import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/class/store.dart';
import 'package:titan/paiement/providers/store_provider.dart';
import 'package:titan/paiement/providers/stores_list_provider.dart';
import 'package:titan/paiement/router.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminStoreCard extends ConsumerWidget {
  final Store store;
  const AdminStoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeNotifier = ref.watch(storeProvider.notifier);
    final storeListNotifier = ref.watch(storeListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 29, 29).withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                store.name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 29, 29),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  storeNotifier.updateStore(store);
                  QR.to(
                    PaymentRouter.root +
                        PaymentRouter.admin +
                        PaymentRouter.addEditStore,
                  );
                },
                child: const CardButton(
                  colors: [
                    Color.fromARGB(255, 6, 75, 75),
                    Color.fromARGB(255, 0, 29, 29),
                  ],
                  child: HeroIcon(HeroIcons.pencilSquare, color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              WaitingButton(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => CustomDialogBox(
                      title: "Supprimer l'association",
                      descriptions:
                          "Voulez-vous vraiment supprimer cette association ?",
                      onYes: () {
                        tokenExpireWrapper(ref, () async {
                          final value = await storeListNotifier.deleteStore(
                            store,
                          );
                          if (value) {
                            displayToastWithContext(
                              TypeMsg.msg,
                              "Association supprimée",
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              "Impossible de supprimer l'association",
                            );
                          }
                        });
                      },
                    ),
                  );
                },
                builder: (child) => CardButton(
                  colors: const [Color(0xFF9E131F), Color(0xFF590512)],
                  child: child,
                ),
                child: const HeroIcon(HeroIcons.trash, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/store.dart';
import 'package:titan/mypayment/providers/store_provider.dart';
import 'package:titan/mypayment/providers/stores_list_provider.dart';
import 'package:titan/mypayment/router.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/theme_provider.dart';
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
    final isDarkTheme = ref.watch(themeProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
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
                style: TextStyle(
                  fontSize: 20,
                  color: MyPaymentColors(isDarkTheme).backgroundGradient2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  storeNotifier.updateStore(store);
                  QR.to(
                    PaymentRouter.root +
                        PaymentRouter.structureStores +
                        PaymentRouter.addEditStore,
                  );
                },
                child: CardButton(
                  colors: [
                    MyPaymentColors(isDarkTheme).backgroundGradient1,
                    MyPaymentColors(isDarkTheme).backgroundGradient2,
                  ],
                  child: HeroIcon(
                    HeroIcons.pencilSquare,
                    color: MyPaymentColors.onGradient,
                  ),
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
                  colors: [
                    MyPaymentColors(isDarkTheme).redGradient1,
                    MyPaymentColors(isDarkTheme).redGradient2,
                  ],
                  child: child,
                ),
                child: const HeroIcon(
                  HeroIcons.trash,
                  color: MyPaymentColors.onGradient,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

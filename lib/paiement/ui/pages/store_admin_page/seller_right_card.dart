import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/paiement/class/seller.dart';
import 'package:titan/paiement/providers/selected_store_provider.dart';
import 'package:titan/paiement/providers/store_sellers_list_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class SellerRightCard extends ConsumerWidget {
  final Seller me;
  final Seller storeSeller;
  const SellerRightCard({
    super.key,
    required this.me,
    required this.storeSeller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(selectedStoreProvider);
    final sellerStoreNotifier = ref.watch(
      sellerStoreProvider(store.id).notifier,
    );
    final rightsIcons = [];
    final rightsLabel = [];

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final amIAdmin = me.userId == store.structure.managerUser.id;

    final isStructureAdmin =
        storeSeller.userId == store.structure.managerUser.id;

    final icons =
        [
              HeroIcons.viewfinderCircle,
              HeroIcons.wallet,
              HeroIcons.xMark,
              HeroIcons.userGroup,
            ]
            .map(
              (e) => CardButton(
                size: 35,
                colors: const [
                  Color.fromARGB(255, 6, 75, 75),
                  Color.fromARGB(255, 0, 29, 29),
                ],
                child: HeroIcon(e, color: Colors.white, size: 20),
              ),
            )
            .toList();
    icons.add(
      const CardButton(
        size: 35,
        colors: [
          Color.fromARGB(255, 255, 119, 7),
          Color.fromARGB(255, 186, 84, 1),
        ],
        child: HeroIcon(HeroIcons.userGroup, color: Colors.white, size: 20),
      ),
    );

    final labels = [
      "Encaisser",
      "Voir l'historique",
      "Annuler les transactions",
      "Gérer les vendeurs",
      "Administrateur de la structure",
    ];

    List<bool> sellerRights = [
      storeSeller.canBank,
      storeSeller.canSeeHistory,
      storeSeller.canCancel,
      storeSeller.canManageSellers,
    ];

    for (var i = 0; i < sellerRights.length; i++) {
      if (sellerRights[i]) {
        rightsLabel.add(labels[i]);
        rightsIcons.add(icons[i]);
      }
    }

    if (isStructureAdmin) {
      rightsLabel.add(labels[4]);
      rightsIcons.add(icons[4]);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            scrollControlDisabledMaxHeightRatio:
                (((!amIAdmin || isStructureAdmin) ? 80 : 100) +
                    45 * icons.length) /
                MediaQuery.of(context).size.height,
            builder: (context) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Expanded(
                        child: Text(
                          "Droits de ${storeSeller.user.nickname ?? ("${storeSeller.user.firstname} ${storeSeller.user.name}")}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 29, 29),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (var i = 0; i < icons.length; i++)
                        if (i < 4 || isStructureAdmin)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                icons[i],
                                const SizedBox(width: 15),
                                Text(
                                  labels[i],
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 29, 29),
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                if (me.canManageSellers && !isStructureAdmin)
                                  Checkbox(
                                    value: sellerRights[i],
                                    activeColor: const Color(0xff204550),
                                    visualDensity: const VisualDensity(
                                      horizontal: -4,
                                      vertical: -4,
                                    ),
                                    onChanged: (value) async {
                                      await tokenExpireWrapper(ref, () async {
                                        final value = await sellerStoreNotifier
                                            .updateStoreSeller(
                                              storeSeller.copyWith(
                                                canBank: i == 0
                                                    ? !sellerRights[0]
                                                    : sellerRights[0],
                                                canSeeHistory: i == 1
                                                    ? !sellerRights[1]
                                                    : sellerRights[1],
                                                canCancel: i == 2
                                                    ? !sellerRights[2]
                                                    : sellerRights[2],
                                                canManageSellers: i == 3
                                                    ? !sellerRights[3]
                                                    : sellerRights[3],
                                              ),
                                            );
                                        if (value) {
                                          displayToastWithContext(
                                            TypeMsg.msg,
                                            "Droits mis à jour",
                                          );
                                          sellerRights[i] = !sellerRights[i];
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        } else {
                                          displayToastWithContext(
                                            TypeMsg.error,
                                            "Impossible de mettre à jour les droits",
                                          );
                                        }
                                      });
                                    },
                                  ),
                              ],
                            ),
                          ),
                      if (me.canManageSellers && !isStructureAdmin)
                        GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => CustomDialogBox(
                                title: "Supprimer l'association",
                                descriptions:
                                    "Voulez-vous vraiment supprimer ce vendeur ?",
                                onYes: () {
                                  tokenExpireWrapper(ref, () async {
                                    final value = await sellerStoreNotifier
                                        .deleteStoreSeller(storeSeller);
                                    if (value) {
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        "Vendeur supprimé",
                                      );
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        "Impossible de supprimer le vendeur",
                                      );
                                    }
                                  });
                                },
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: AddEditButtonLayout(
                              colors: [Color(0xFF9E131F), Color(0xFF590512)],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HeroIcon(
                                    HeroIcons.trash,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    "Supprimer le vendeur",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                storeSeller.user.nickname ??
                    ("${storeSeller.user.firstname} ${storeSeller.user.name}"),
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 29, 29),
                  fontSize: 14,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 25 * icons.length.toDouble() + 15,
              height: 40,
              child: Stack(
                children: List.generate(rightsIcons.length, (index) {
                  return Positioned(
                    left: (icons.length - rightsIcons.length + index) * 25,
                    child: rightsIcons[index],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/paiement/class/seller.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';

class SellerRightCard extends StatelessWidget {
  final Seller storeSeller;
  const SellerRightCard({super.key, required this.storeSeller});

  @override
  Widget build(BuildContext context) {
    final rightsIcons = [];
    final rightsLabel = [];

    final icons = [
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
            child: HeroIcon(
              e,
              color: Colors.white,
              size: 20,
            ),
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
        child: HeroIcon(
          HeroIcons.userGroup,
          color: Colors.white,
          size: 20,
        ),
      ),
    );

    final labels = [
      "Scanner",
      "Voir l'historique",
      "Annuler un paiement",
      "Gérer les vendeurs",
      "Administrateur général",
    ];

    final sellerRights = [
      storeSeller.canBank,
      storeSeller.canSeeHistory,
      storeSeller.canCancel,
      storeSeller.canManageSellers,
      storeSeller.storeAdmin,
    ];

    for (var i = 0; i < sellerRights.length; i++) {
      if (sellerRights[i]) {
        rightsLabel.add(labels[i]);
        if (i == 4) {
          rightsIcons.add(
            icons[i],
          );
        } else {
          rightsIcons.add(
            icons[i],
          );
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            scrollControlDisabledMaxHeightRatio: (80 + 45 * icons.length + 55) /
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
                      const SizedBox(
                        height: 20,
                      ),
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
                      const SizedBox(
                        height: 10,
                      ),
                      for (var i = 0; i < icons.length; i++)
                        if (i < 4 || storeSeller.storeAdmin)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                icons[i],
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  labels[i],
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 29, 29),
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                if (!storeSeller.storeAdmin)
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).pop();
                                    },
                                    child: HeroIcon(
                                      sellerRights[i]
                                          ? HeroIcons.check
                                          : HeroIcons.xMark,
                                      color:
                                          const Color.fromARGB(255, 0, 29, 29),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      if (storeSeller.storeAdmin)
                        GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: AddEditButtonLayout(
                              colors: [
                                Color(0xFF9E131F),
                                Color(0xFF590512),
                              ],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HeroIcon(
                                    HeroIcons.trash,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
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
                      const SizedBox(
                        height: 10,
                      ),
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
                    child: icons[index],
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

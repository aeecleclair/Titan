import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/collection_slot_provider.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/is_amap_admin_provider.dart';
import 'package:myecl/amap/tools/collection_dialog.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/dialog.dart';
import 'package:myecl/amap/tools/functions.dart';

class DeliveryUi extends ConsumerWidget {
  final Delivery c;
  final String i;
  const DeliveryUi({Key? key, required this.c, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isAmapAdminProvider);
    final deliveryListNotifier = ref.watch(deliveryListProvider.notifier);
    final deliveryIdNotifier = ref.watch(deliveryIdProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final collectionSlotNotifier = ref.watch(collectionSlotProvider.notifier);
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: Colors.grey.shade50,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.background3.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(2, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 30,
                height: 60,
              ),
              Expanded(
                child: Text(
                  "Livraison le " +
                      c.deliveryDate.day.toString().padLeft(2, "0") +
                      "/" +
                      c.deliveryDate.month.toString().padLeft(2, "0") +
                      "/" +
                      c.deliveryDate.year.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.l1),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 50,
                  height: 25,
                  alignment: Alignment.topCenter,
                  child: HeroIcon(
                    c.expanded ? HeroIcons.chevronUp : HeroIcons.chevronDown,
                    color: ColorConstants.textDark,
                  ),
                ),
                onTap: () {
                  deliveryListNotifier.toggleExpanded(i);
                },
              )
            ],
          ),
          c.expanded
              ? Column(
                  children: c.products
                      .map((p) => Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          alignment: Alignment.center,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  p.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: ColorConstants.textDark,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: 15,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      p.price.toStringAsFixed(2) + "€",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: ColorConstants.textDark,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                ],
                              )
                            ],
                          )))
                      .toList())
              : Container(),
          Container(
            height: 10,
          ),
          !c.locked
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 25,
                    ),
                    Container(
                      width: 140,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        c.products.length.toString() +
                            " produit" +
                            (c.products.length != 1 ? "s" : ""),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.textLight),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 140,
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              colors: [
                                ColorConstants.textLight,
                                ColorConstants.textDark,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Text(
                            "Commander",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.background2),
                          ),
                        ),
                        onTap: () {
                          deliveryIdNotifier.setId(i);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CollectionDialogBox(
                                      descriptions:
                                          "Choisissez un moment de livraison",
                                      title: "Livraison",
                                      onClick: (s) {
                                        collectionSlotNotifier.setSlot(s);
                                        pageNotifier
                                            .setAmapPage(AmapPage.products);
                                      }));
                        },
                      ),
                    ),
                  ],
                )
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [
                        ColorConstants.redGradient1,
                        ColorConstants.redGradient2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.lock,
                        color: ColorConstants.background2,
                        size: 20,
                      ),
                      Container(
                        width: 20,
                      ),
                      Text(
                        "Commandé vérouillée",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.background2),
                      ),
                    ],
                  ),
                ),
          Container(
            height: 20,
          ),
          c.expanded && isAdmin
              ? Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 70,
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(23),
                                topLeft: Radius.circular(23)),
                            color: ColorConstants.background3),
                        alignment: Alignment.center,
                        child: const Text("Vérouiller",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.enabled)),
                      ),
                      onTap: () {
                        final lastState = c.locked;
                        deliveryListNotifier
                            .updateDelivery(c.copyWith(
                          locked: !c.locked,
                        ))
                            .then((value) {
                          if (value) {
                            if (lastState) {
                              displayToast(context, TypeMsg.msg,
                                  "Livraison vérrouillée");
                            } else {
                              displayToast(context, TypeMsg.msg,
                                  "Livraison dévérrouillée");
                            }
                          } else {
                            displayToast(context, TypeMsg.error,
                                "Erreur lors de la mise à jour");
                          }
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 70,
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(23),
                                topRight: Radius.circular(23)),
                            color: ColorConstants.background3),
                        alignment: Alignment.center,
                        child: const Text("Supprimer",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 144, 54, 61))),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => CustomDialogBox(
                                descriptions: "Supprimer la livraison ?",
                                title: "Suppression",
                                onYes: () {
                                  deliveryListNotifier
                                      .deleteDelivery(i)
                                      .then((value) {
                                    if (value) {
                                      displayToast(context, TypeMsg.msg,
                                          "livraison supprimée");
                                    } else {
                                      displayToast(context, TypeMsg.error,
                                          "Erreur lors de la suppression");
                                    }
                                  });
                                }));
                      },
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}

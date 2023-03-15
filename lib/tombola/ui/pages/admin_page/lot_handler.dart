import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/providers/lot_list_provider.dart';
import 'package:myecl/tombola/providers/lot_provider.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/lot_card.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class LotHandler extends HookConsumerWidget {
  const LotHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    final lotNotifier = ref.watch(lotProvider.notifier);
    final lotsNotifier = ref.watch(lotListProvider.notifier);
    final lotList = ref.watch(lotListProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text("Lots",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: TombolaColorConstants.textDark)),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(children: [
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                lotNotifier.setLot(Lot.empty());
                pageNotifier.setTombolaPage(TombolaPage.addEditLot);
              },
              child: Container(
                  margin: const EdgeInsets.only(left: 5.0, bottom: 10),
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 100,
                    height: 125,
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        colors: [
                          Color(0xff0193a5),
                          Color(0xff004a59),
                        ],
                        center: Alignment.topLeft,
                        radius: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color:
                              TombolaColorConstants.textDark.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: HeroIcon(
                        HeroIcons.plus,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  )),
            ),
            lotList.when(data: (lots) {
              return lots.isEmpty
                  ? const Center(
                      child: Text("Aucun produit"),
                    )
                  : Row(
                      children: lots
                          .map(
                            (e) => LotCard(
                              lot: e,
                              onDelete: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) => CustomDialogBox(
                                          title: "Supprimer le produit",
                                          descriptions:
                                              "Voulez-vous vraiment supprimer ce produit?",
                                          onYes: () {
                                            tokenExpireWrapper(ref, () async {
                                              final value = await lotsNotifier
                                                  .deleteLot(e);
                                              if (value) {
                                                displayToastWithContext(
                                                    TypeMsg.msg,
                                                    TombolaTextConstants
                                                        .deletedlot);
                                              } else {
                                                displayToastWithContext(
                                                    TypeMsg.error,
                                                    TombolaTextConstants
                                                        .deletingError);
                                              }
                                            });
                                          },
                                        ));
                              },
                              onEdit: () {
                                lotNotifier.setLot(e);
                                pageNotifier
                                    .setTombolaPage(TombolaPage.addEditLot);
                              },
                            ),
                          )
                          .toList(),
                    );
            }, error: (Object error, StackTrace stackTrace) {
              return Center(
                child: Text("error : $error"),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
            const SizedBox(
              width: 10,
            )
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

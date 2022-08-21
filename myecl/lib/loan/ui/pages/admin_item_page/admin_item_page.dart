import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan_button.dart';
import 'package:myecl/loan/ui/pages/admin_item_page/item_ui.dart';
import 'package:myecl/loan/ui/refresh_indicator.dart';

class AdminItemPage extends HookConsumerWidget {
  const AdminItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final items = ref.watch(loanersItemsProvider);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loaners = ref.watch(loanerList);
    List<Widget> listWidget = [
      Container(
        margin: const EdgeInsets.only(right: 10, left: 20),
        height: 48,
        alignment: Alignment.centerLeft,
        child: const Text(
          "Objets disponibles",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    ];

    items.when(
      data: (loaners) {
        if (loaners.isNotEmpty) {
          List<String> categories =
              (loaners.keys.toList()).map((e) => e.name).toList();
          Map<String, List<Widget>> dictCateListWidget = {
            for (var item in categories) item: []
          };
          for (Loaner l in loaners.keys) {
            if (loaners[l]!.item2) {
              loaners[l]?.item1.when(
                    data: (items) {
                      if (items.isNotEmpty) {
                        for (Item i in items) {
                          dictCateListWidget[l.name]!.add(
                            ItemUi(l: i, loaner: l),
                          );
                        }
                      } else {
                        dictCateListWidget[l.name]!.add(
                          Container(
                            height: 55,
                            alignment: Alignment.centerLeft,
                            child: const Center(
                              child: Text(
                                "Aucun objet disponible",
                                style: TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    error: (error, stackTrace) {},
                    loading: () {},
                  );
            }
          }

          for (Loaner l in loaners.keys) {
            listWidget.add(GestureDetector(
                child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            l.name,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        loaners[l]!.item1.when(
                          data: (items) {
                            return Container(
                                padding: const EdgeInsets.only(right: 20),
                                child: !loaners[l]!.item2
                                    ? const HeroIcon(
                                        HeroIcons.chevronUp,
                                      )
                                    : const HeroIcon(
                                        HeroIcons.chevronDown,
                                      ));
                          },
                          error: (error, stackTrace) {
                            return Container(
                                padding: const EdgeInsets.only(right: 20),
                                child: !loaners[l]!.item2
                                    ? const HeroIcon(
                                        HeroIcons.chevronUp,
                                      )
                                    : const HeroIcon(
                                        HeroIcons.chevronDown,
                                      ));
                          },
                          loading: () {
                            return Container(
                                padding: const EdgeInsets.only(right: 20),
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    LoanColorConstants.darkGrey,
                                  ),
                                ));
                          },
                        ),
                      ],
                    )),
                onTap: () async {
                  var loaded = await loanersitemsNotifier.toggleExpanded(l);
                  if (!loaded) {
                    itemListNotifier.setId(l.id);
                    itemListNotifier.loadItemList();
                    loanersitemsNotifier.setLoanerItems(
                        l, await itemListNotifier.copy());
                  }
                }));

            listWidget += dictCateListWidget[l.name] ?? [];
          }
        } else {
          listWidget.add(Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                LoanTextConstants.noLoan,
              ),
            ),
          ));
        }
      },
      loading: () {
        listWidget.add(const Center(
            child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(LoanColorConstants.darkGrey),
        )));
      },
      error: (error, s) {
        listWidget.add(Center(child: Text(error.toString())));
      },
    );

    return LoanRefresher(
      onRefresh: () async {
        loanersitemsNotifier.loadLoanerList(loaners);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              child: const LoanCommonButton(text: LoanTextConstants.addObject),
              onTap: () {
                pageNotifier.setLoanPage(LoanPage.addItem);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ...listWidget,
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

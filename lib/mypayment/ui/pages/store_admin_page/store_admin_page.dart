import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/providers/selected_store_provider.dart';
import 'package:titan/mypayment/providers/store_sellers_list_provider.dart';
import 'package:titan/mypayment/ui/pages/store_admin_page/search_result.dart';
import 'package:titan/mypayment/ui/pages/store_admin_page/seller_right_card.dart';
import 'package:titan/mypayment/ui/mypayment.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:titan/user/providers/user_provider.dart';

class StoreAdminPage extends HookConsumerWidget {
  const StoreAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(selectedStoreProvider);
    final storeSellers = ref.watch(sellerStoreProvider(store.id));
    final storeSellersNotifier = ref.read(
      sellerStoreProvider(store.id).notifier,
    );
    final usersNotifier = ref.watch(userList.notifier);
    final queryController = useTextEditingController();
    final isSearching = useState(false);

    final me = ref.watch(userProvider);

    return PaymentTemplate(
      child: Refresher(
        onRefresh: () async {
          await storeSellersNotifier.getStoreSellerList(store.id);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Les vendeurs de ${store.name}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 29, 29),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (!isSearching.value) ...[
              GestureDetector(
                onTap: () {
                  isSearching.value = true;
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Ajouter un vendeur",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 29, 29),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Spacer(),
                      CardButton(
                        size: 35,
                        child: HeroIcon(
                          HeroIcons.plus,
                          color: Color.fromARGB(255, 0, 29, 29),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              AsyncChild(
                value: storeSellers,
                builder: (context, storeSellers) {
                  final mySellers = storeSellers
                      .where((seller) => seller.user.id == me.id)
                      .firstOrNull;
                  if (mySellers == null) {
                    return const Center(
                      child: Text('You are not a seller in this store'),
                    );
                  }
                  return Column(
                    children: [
                      ...storeSellers.map((storeSeller) {
                        return SellerRightCard(
                          me: mySellers,
                          storeSeller: storeSeller,
                        );
                      }),
                    ],
                  );
                },
              ),
            ],
            if (isSearching.value) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: TextEntry(
                        label: "Ajouter un vendeur",
                        onChanged: (value) {
                          tokenExpireWrapper(ref, () async {
                            if (queryController.text.isNotEmpty) {
                              await usersNotifier.filterUsers(
                                queryController.text,
                              );
                            } else {
                              usersNotifier.clear();
                            }
                          });
                        },
                        canBeEmpty: false,
                        controller: queryController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        isSearching.value = false;
                        queryController.clear();
                        usersNotifier.clear();
                      },
                      child: const HeroIcon(
                        HeroIcons.xMark,
                        size: 30,
                        color: Color.fromARGB(255, 0, 29, 29),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              AsyncChild(
                value: storeSellers,
                builder: (context, storeSellers) => SearchResult(
                  sellers: storeSellers
                      .map((seller) => seller.user.id)
                      .toList(),
                  queryController: queryController,
                  onChoose: () => isSearching.value = false,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

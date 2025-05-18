import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/seller.dart';
import 'package:myecl/paiement/providers/new_admin_provider.dart';
import 'package:myecl/paiement/providers/selected_store_provider.dart';
import 'package:myecl/paiement/providers/store_sellers_list_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  final void Function() onChoose;
  const SearchResult({
    super.key,
    required this.queryController,
    required this.onChoose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(selectedStoreProvider);
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final newAdmin = ref.watch(newAdminProvider);
    final newAdminNotifier = ref.watch(newAdminProvider.notifier);
    final sellerStoreNotifier =
        ref.watch(sellerStoreProvider(store.id).notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AsyncChild(
      value: users,
      builder: (context, user) => Column(
        children: user
            .map(
              (simpleUser) => GestureDetector(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WaitingButton(
                        onTap: () async {
                          await tokenExpireWrapper(ref, () async {
                            newAdminNotifier.updateNewAdmin(simpleUser);
                            queryController.text = simpleUser.getName();
                            Seller seller = Seller(
                              storeId: store.id,
                              userId: simpleUser.id,
                              user: simpleUser,
                              canBank: true,
                              canSeeHistory: true,
                              canCancel: true,
                              canManageSellers: true,
                            );
                            final value = await sellerStoreNotifier
                                .createStoreSeller(seller);
                            if (value) {
                              usersNotifier.clear();
                              displayToastWithContext(
                                TypeMsg.msg,
                                "Vendeur ajouté",
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                "Erreur lors de l'ajout",
                              );
                            }
                          });
                          onChoose();
                        },
                        waitingColor: const Color(0xff017f80),
                        builder: (child) => child,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: const Color(0xff017f80),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: const HeroIcon(
                              HeroIcons.plus,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        simpleUser.getName(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: simpleUser.id == newAdmin.id
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

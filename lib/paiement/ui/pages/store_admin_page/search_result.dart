import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/seller.dart';
import 'package:myecl/paiement/providers/new_admin_provider.dart';
import 'package:myecl/paiement/providers/selected_structure_provider.dart';
import 'package:myecl/paiement/providers/store_provider.dart';
import 'package:myecl/paiement/providers/store_sellers_list_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  const SearchResult({super.key, required this.queryController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(storeProvider);
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final newAdmin = ref.watch(newAdminProvider);
    final newAdminNotifier = ref.watch(newAdminProvider.notifier);
    final selectedStructure = ref.read(selectedStructureProvider);
    final sellerStoreNotifier =
        ref.watch(sellerStoreProvider(selectedStructure.id).notifier);

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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WaitingButton(
                        onTap: () async {
                          tokenExpireWrapper(ref, () async {
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
                              storeAdmin: true,
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
                        },
                        waitingColor: const Color.fromARGB(255, 0, 29, 29),
                        builder: (child) => child,
                        child: const HeroIcon(
                          HeroIcons.plus,
                          color: Color.fromARGB(255, 0, 29, 29),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        simpleUser.getName(),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 29, 29),
                          fontSize: 14,
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

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/seller.dart';
import 'package:titan/mypayment/providers/new_admin_provider.dart';
import 'package:titan/mypayment/providers/selected_store_provider.dart';
import 'package:titan/mypayment/providers/seller_rights_list_providder.dart';
import 'package:titan/mypayment/providers/store_sellers_list_provider.dart';
import 'package:titan/mypayment/ui/pages/store_admin_page/right_check_box.dart';
import 'package:titan/mypayment/ui/pages/store_admin_page/seller_right_dialog.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  final void Function() onChoose;
  final List<String> sellers;
  const SearchResult({
    super.key,
    required this.sellers,
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
    final sellerStoreNotifier = ref.watch(
      sellerStoreProvider(store.id).notifier,
    );
    final sellerRightsListNotifier = ref.watch(
      sellerRightsListProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    Future handleUserSelected(SimpleUser simpleUser) async {
      await showDialog(
        context: context,
        builder: (context) {
          return Consumer(
            builder: (context, ref, _) {
              final sellerRightsList = ref.watch(sellerRightsListProvider);
              return SellerRightDialog(
                title: "Droit du vendeur",
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RightCheckBox(title: "Peut encaisser", index: 0),
                    RightCheckBox(title: "Peut voir l'historique", index: 1),
                    RightCheckBox(
                      title: "Peut annuler des transactions",
                      index: 2,
                    ),
                    RightCheckBox(title: "Peut gérer les vendeurs", index: 3),
                  ],
                ),
                onYes: () async {
                  await tokenExpireWrapper(ref, () async {
                    newAdminNotifier.updateNewAdmin(simpleUser);
                    queryController.text = simpleUser.getName();
                    Seller seller = Seller(
                      storeId: store.id,
                      userId: simpleUser.id,
                      user: simpleUser,
                      canBank: sellerRightsList[0],
                      canSeeHistory: sellerRightsList[1],
                      canCancel: sellerRightsList[2],
                      canManageSellers: sellerRightsList[3],
                    );
                    final value = await sellerStoreNotifier.createStoreSeller(
                      seller,
                    );
                    if (value) {
                      queryController.clear();
                      usersNotifier.clear();
                      sellerRightsListNotifier.clearRights();
                      newAdminNotifier.resetNewAdmin();
                      displayToastWithContext(TypeMsg.msg, "Vendeur ajouté");
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    } else {
                      displayToastWithContext(
                        TypeMsg.error,
                        "Erreur lors de l'ajout",
                      );
                    }
                  });
                  onChoose();
                },
              );
            },
          );
        },
      );
    }

    return AsyncChild(
      value: users,
      builder: (context, user) {
        final List<SimpleUser> filteredUsers = user
            .where((simpleUser) => !sellers.contains(simpleUser.id))
            .toList();
        return Column(
          children: filteredUsers
              .map(
                (simpleUser) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 5,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          simpleUser.getName(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: simpleUser.id == newAdmin.id
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        const Spacer(),
                        WaitingButton(
                          onTap: () async {
                            await handleUserSelected(simpleUser);
                          },
                          waitingColor: Colors.black,
                          builder: (child) => child,
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: Center(
                              child: const HeroIcon(
                                HeroIcons.plus,
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

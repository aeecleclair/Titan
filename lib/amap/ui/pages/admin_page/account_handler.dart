import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/providers/focus_provider.dart';
import 'package:myecl/amap/providers/searching_amap_user_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/admin_page/adding_user_container.dart';
import 'package:myecl/amap/ui/pages/admin_page/cash_container.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AccountHandler extends HookConsumerWidget {
  const AccountHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashNotifier = ref.read(cashProvider.notifier);
    final usersNotifier = ref.read(userList.notifier);
    final editingController = useTextEditingController();
    final searchingAmapUser = ref.watch(searchingAmapUserProvider);
    final searchingAmapUserNotifier =
        ref.read(searchingAmapUserProvider.notifier);
    final focus = ref.watch(focusProvider);
    final focusNotifier = ref.read(focusProvider.notifier);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.centerLeft,
        child: TextField(
          onChanged: (value) {
            tokenExpireWrapper(ref, () async {
              if (!searchingAmapUser) {
                if (editingController.text.isNotEmpty) {
                  await usersNotifier.filterUsers(editingController.text);
                } else {
                  usersNotifier.clear();
                }
              } else {
                if (editingController.text.isNotEmpty) {
                  await cashNotifier.filterCashList(editingController.text);
                } else {
                  cashNotifier.refreshCashList();
                }
              }
            });
          },
          focusNode: focusNode,
          controller: editingController,
          cursorColor: AMAPColorConstants.textDark,
          decoration: const InputDecoration(
              labelText: AMAPTextConstants.accounts,
              labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AMAPColorConstants.textDark),
              suffixIcon: Icon(
                Icons.search,
                color: AMAPColorConstants.textDark,
                size: 30,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AMAPColorConstants.textDark,
                ),
              )),
        ),
      ),
      SizedBox(
        height: 135,
        child: HorizontalListView(
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Container(
                  height: 135,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 17),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        colors: [
                          AMAPColorConstants.green1,
                          AMAPColorConstants.textLight,
                        ],
                        center: Alignment.topLeft,
                        radius: 1.3,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AMAPColorConstants.textDark.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: !searchingAmapUser
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    searchingAmapUserNotifier.setProduct(true);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: const HeroIcon(
                                      HeroIcons.xMark,
                                      color: Color.fromARGB(223, 244, 255, 183),
                                      size: 50,
                                    ),
                                  ),
                                ),
                                AddingUserContainer(onAdd: () async {
                                  searchingAmapUserNotifier.setProduct(true);
                                })
                              ],
                            )
                          : GestureDetector(
                              onTap: () async {
                                searchingAmapUserNotifier.setProduct(false);
                                if (editingController.text.isNotEmpty) {
                                  await usersNotifier
                                      .filterUsers(editingController.text);
                                } else {
                                  usersNotifier.clear();
                                }
                                focusNotifier.setFocus(true);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: const HeroIcon(
                                  HeroIcons.plus,
                                  color: Color.fromARGB(223, 244, 255, 183),
                                  size: 50,
                                ),
                              )),
                    ),
                  )),
              const CashContainer(),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      )
    ]);
  }
}

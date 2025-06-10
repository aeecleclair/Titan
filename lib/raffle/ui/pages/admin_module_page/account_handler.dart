import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/providers/cash_provider.dart';
import 'package:titan/raffle/providers/focus_provider.dart';
import 'package:titan/raffle/providers/searching_raffle_user_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/pages/admin_module_page/adding_user_container.dart';
import 'package:titan/raffle/ui/pages/admin_module_page/cash_container.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class AccountHandler extends HookConsumerWidget {
  const AccountHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashNotifier = ref.watch(cashProvider.notifier);
    final usersNotifier = ref.watch(userList.notifier);
    final editingController = useTextEditingController();
    final searchingAmapUser = ref.watch(searchingAmapUserProvider);
    final searchingAmapUserNotifier = ref.watch(
      searchingAmapUserProvider.notifier,
    );
    final focus = ref.watch(focusProvider);
    final focusNotifier = ref.watch(focusProvider.notifier);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }
    return Column(
      children: [
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
            cursorColor: RaffleColorConstants.textDark,
            decoration: const InputDecoration(
              labelText: RaffleTextConstants.accounts,
              labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: RaffleColorConstants.textDark,
              ),
              suffixIcon: Icon(
                Icons.search,
                color: RaffleColorConstants.textDark,
                size: 30,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: RaffleColorConstants.textDark),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 135,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        colors: [
                          RaffleColorConstants.gradient1,
                          RaffleColorConstants.gradient2,
                        ],
                        center: Alignment.topLeft,
                        radius: 1.8,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: RaffleColorConstants.textDark.withValues(
                            alpha: 0.2,
                          ),
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
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(FocusNode());
                                    focusNotifier.setFocus(false);
                                    editingController.clear();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                    ),
                                    child: const HeroIcon(
                                      HeroIcons.xMark,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                AddingUserContainer(
                                  onAdd: () async {
                                    searchingAmapUserNotifier.setProduct(true);
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(FocusNode());
                                    focusNotifier.setFocus(false);
                                    await cashNotifier.filterCashList(
                                      editingController.text,
                                    );
                                    editingController.clear();
                                  },
                                ),
                              ],
                            )
                          : GestureDetector(
                              onTap: () {
                                searchingAmapUserNotifier.setProduct(false);
                                focusNotifier.setFocus(true);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: const HeroIcon(
                                  HeroIcons.plus,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                const CashContainer(),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/cash_list_provider.dart';
import 'package:myecl/amap/providers/focus_provider.dart';
import 'package:myecl/amap/providers/searching_amap_user_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/admin_page/adding_user_container.dart';
import 'package:myecl/amap/ui/pages/admin_page/cash_container.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/widgets/styled_search_bar.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AccountHandler extends HookConsumerWidget {
  const AccountHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashNotifier = ref.read(cashListProvider.notifier);
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
      StyledSearchBar(
        label: AMAPTextConstants.accounts,
        color: AMAPColorConstants.textDark,
        onChanged: (value) async {
          if (!searchingAmapUser) {
            if (value.isNotEmpty) {
              await usersNotifier.filterUsers(value);
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
        },
      ),
      HorizontalListView(
        height: 135,
        children: [
          const SizedBox(width: 15),
          CardLayout(
            height: 100,
            width: 100,
            colors: const [
              AMAPColorConstants.green1,
              AMAPColorConstants.textLight
            ],
            shadowColor: AMAPColorConstants.textDark.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: !searchingAmapUser
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          searchingAmapUserNotifier.setProduct(true);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: const HeroIcon(
                            HeroIcons.xMark,
                            color: AMAPColorConstants.green3,
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
                        await usersNotifier.filterUsers(editingController.text);
                      } else {
                        usersNotifier.clear();
                      }
                      focusNotifier.setFocus(true);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: const HeroIcon(
                        HeroIcons.plus,
                        color: AMAPColorConstants.green3,
                        size: 50,
                      ),
                    )),
          ),
          const CashContainer(),
          const SizedBox(width: 10),
        ],
      ),
    ]);
  }
}

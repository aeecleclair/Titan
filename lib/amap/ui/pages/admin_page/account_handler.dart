import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/providers/cash_list_provider.dart';
import 'package:titan/amap/providers/searching_amap_user_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/pages/admin_page/adding_user_container.dart';
import 'package:titan/amap/ui/pages/admin_page/cash_container.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class AccountHandler extends HookConsumerWidget {
  const AccountHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashNotifier = ref.read(cashListProvider.notifier);
    final usersNotifier = ref.read(userList.notifier);
    final editingController = useTextEditingController();
    final searchingAmapUser = ref.watch(searchingAmapUserProvider);
    final searchingAmapUserNotifier = ref.read(
      searchingAmapUserProvider.notifier,
    );

    return Column(
      children: [
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
              if (value.isNotEmpty) {
                await cashNotifier.filterCashList(value);
              } else {
                cashNotifier.refreshCashList();
              }
            }
          },
          editingController: editingController,
        ),
        HorizontalListView(
          height: 135,
          children: [
            const SizedBox(width: 15),
            GestureDetector(
              onTap: searchingAmapUser
                  ? () async {
                      searchingAmapUserNotifier.setProduct(false);
                      if (editingController.text.isNotEmpty) {
                        await usersNotifier.filterUsers(editingController.text);
                      }
                    }
                  : () async {
                      searchingAmapUserNotifier.setProduct(true);
                      if (editingController.text.isNotEmpty) {
                        await cashNotifier.filterCashList(
                          editingController.text,
                        );
                      }
                    },
              child: CardLayout(
                height: 100,
                width: 100,
                colors: const [
                  AMAPColorConstants.green1,
                  AMAPColorConstants.textLight,
                ],
                shadowColor: AMAPColorConstants.textDark.withValues(alpha: 0.2),
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: HeroIcon(
                    searchingAmapUser ? HeroIcons.plus : HeroIcons.xMark,
                    color: AMAPColorConstants.green3,
                    size: 50,
                  ),
                ),
              ),
            ),
            searchingAmapUser
                ? const CashContainer()
                : AddingUserContainer(
                    onAdd: () async {
                      searchingAmapUserNotifier.setProduct(true);
                    },
                  ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/super_admin/class/account_type.dart';
import 'package:titan/super_admin/providers/account_types_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:titan/user/repositories/user_repository.dart';

class AccountTypesPage extends HookConsumerWidget {
  const AccountTypesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final accountTypes = ref.watch(allAccountTypesListProvider);
    final userRepository = ref.watch(userRepositoryProvider);
    final scrollController = useScrollController();
    final lastQuery = useState<String>('');

    useEffect(() {
      return () {
        usersNotifier.clear();
      };
    }, const []);

    Future<void> refreshSearch() async {
      if (lastQuery.value.isNotEmpty) {
        await usersNotifier.filterUsers(lastQuery.value);
      }
    }

    Future<void> openAccountTypeSelector(
      SimpleUser user,
      List<AccountType> types,
    ) async {
      AccountType? selected;
      await showCustomBottomModal(
        context: context,
        ref: ref,
        modal: BottomModalTemplate(
          title: l10n.adminAccountTypeSelect,
          child: Column(
            children: types
                .where((t) => t.type != user.accountType.type)
                .map(
                  (type) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: ListItem(
                      title: type.type,
                      onTap: () {
                        selected = type;
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );

      if (selected == null || !context.mounted) return;
      final chosen = selected!;

      await showDialog(
        context: context,
        builder: (dialogContext) => CustomDialogBox(
          title: l10n.adminAccountTypeSelect,
          descriptions: l10n.adminAccountTypeConfirm(
            user.getName(),
            chosen.type,
          ),
          onYes: () async {
            Navigator.of(dialogContext).pop();
            final ok = await tokenExpireWrapper(ref, () async {
              return await userRepository.updateUserAccountType(
                user.id,
                chosen.type,
              );
            });
            if (!context.mounted) return;
            if (ok == true) {
              displayToast(context, TypeMsg.msg, l10n.adminAccountTypeUpdated);
              await refreshSearch();
            } else {
              displayToast(
                context,
                TypeMsg.error,
                l10n.adminAccountTypeUpdateError,
              );
            }
          },
        ),
      );
    }

    return AdminTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.adminAccountTypes,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.title,
              ),
            ),
            const SizedBox(height: 16),
            CustomSearchBar(
              autofocus: true,
              hintText: l10n.adminAccountTypeSearchUser,
              onSearch: (value) => tokenExpireWrapper(ref, () async {
                lastQuery.value = value;
                if (value.isNotEmpty) {
                  await usersNotifier.filterUsers(value);
                } else {
                  usersNotifier.clear();
                }
              }),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AsyncChild(
                value: users,
                builder: (context, data) {
                  if (data.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.adminAccountTypeSearchUser,
                        style: TextStyle(color: ColorConstants.secondary),
                      ),
                    );
                  }
                  return AsyncChild(
                    value: accountTypes,
                    builder: (context, types) => ScrollToHideNavbar(
                      controller: scrollController,
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final user = data[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: ListItem(
                              title: user.getName(),
                              subtitle: user.accountType.type,
                              onTap: () =>
                                  openAccountTypeSelector(user, types),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

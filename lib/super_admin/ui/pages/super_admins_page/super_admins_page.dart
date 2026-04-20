import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/super_admin/ui/admin.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:titan/user/repositories/user_repository.dart';

class SuperAdminsPage extends HookConsumerWidget {
  const SuperAdminsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final userRepository = ref.watch(userRepositoryProvider);
    final scrollController = useScrollController();

    useEffect(() {
      return () {
        usersNotifier.clear();
      };
    }, const []);

    Future<void> openToggleDialog(String userId, String userDisplayName) async {
      final fullUser = await tokenExpireWrapper(ref, () async {
        return await userRepository.getUser(userId);
      });
      if (fullUser == null || !context.mounted) return;

      final currentlySuperAdmin = fullUser.isSuperAdmin;
      final target = !currentlySuperAdmin;

      await showDialog(
        context: context,
        builder: (dialogContext) => CustomDialogBox(
          title: currentlySuperAdmin
              ? l10n.adminSuperAdminDemote
              : l10n.adminSuperAdminPromote,
          descriptions: currentlySuperAdmin
              ? l10n.adminSuperAdminConfirmDemote(userDisplayName)
              : l10n.adminSuperAdminConfirmPromote(userDisplayName),
          onYes: () async {
            Navigator.of(dialogContext).pop();
            final ok = await tokenExpireWrapper(ref, () async {
              return await userRepository.updateUserSuperAdmin(userId, target);
            });
            if (!context.mounted) return;
            if (ok == true) {
              displayToast(context, TypeMsg.msg, l10n.adminSuperAdminUpdated);
            } else {
              displayToast(
                context,
                TypeMsg.error,
                l10n.adminSuperAdminUpdateError,
              );
            }
          },
        ),
      );
    }

    return SuperAdminTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.adminSuperAdmins,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.title,
              ),
            ),
            const SizedBox(height: 16),
            CustomSearchBar(
              autofocus: true,
              hintText: l10n.adminSuperAdminSearchUser,
              onSearch: (value) => tokenExpireWrapper(ref, () async {
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
                        l10n.adminSuperAdminSearchUser,
                        style: TextStyle(color: ColorConstants.secondary),
                      ),
                    );
                  }
                  return ScrollToHideNavbar(
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
                            onTap: () =>
                                openToggleDialog(user.id, user.getName()),
                          ),
                        );
                      },
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

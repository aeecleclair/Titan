import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/admin/ui/pages/users_management_page/users_management_page.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

import 'package:titan/user/providers/user_list_provider.dart';

class AdminMainPage extends HookConsumerWidget {
  const AdminMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userList);

    final localizeWithContext = AppLocalizations.of(context)!;

    return AdminTemplate(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizeWithContext.adminAdministration,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              localizeWithContext.adminUsersAndGroups,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ListItem(
              title: localizeWithContext.adminUsersManagement,
              subtitle: localizeWithContext.adminUsersManagementDescription,
              onTap: () async {
                await showCustomBottomModal(
                  context: context,
                  ref: ref,
                  modal: BottomModalTemplate(
                    title: localizeWithContext.adminUsersManagement,
                    child: UsersManagementPage(),
                  ),
                );
              },
            ),
            ListItem(
              title: localizeWithContext.adminGroupsManagement,
              subtitle: localizeWithContext.adminManageUserGroups,
              onTap: () => QR.to(AdminRouter.root + AdminRouter.usersGroups),
            ),
            ListItem(
              title: localizeWithContext.adminGroupNotification,
              subtitle: localizeWithContext.adminSendNotificationToGroup,
              onTap: () =>
                  QR.to(AdminRouter.root + AdminRouter.groupNotification),
            ),
            Text(
              localizeWithContext.adminPaiementModule,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ListItem(
              title: localizeWithContext.adminPaiement,
              subtitle: localizeWithContext.adminManagePaiementStructures,
              onTap: () => QR.to(AdminRouter.root + AdminRouter.structures),
            ),
            Text(
              localizeWithContext.adminAssociationMembership,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ListItem(
              title: localizeWithContext.adminAssociationMembership,
              subtitle:
                  localizeWithContext.adminManageUsersAssociationMemberships,
              onTap: () =>
                  QR.to(AdminRouter.root + AdminRouter.associationMemberships),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/admin/ui/pages/users_management_page/users_management_page.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

import 'package:titan/user/providers/user_list_provider.dart';

class AdminMainPage extends HookConsumerWidget {
  const AdminMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userList);

    return AdminTemplate(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Gestion", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Text(
              "Utilisateurs & Groupes",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ListItem(
              title: "Gestion des utilisateurs",
              subtitle: "Gérer les utilisateurs de l'application",
              onTap: () async {
                await showCustomBottomModal(
                  context: context,
                  ref: ref,
                  modal: BottomModalTemplate(
                    title: "Gestion des utilisateurs",
                    child: UsersManagementPage(),
                  ),
                );
              },
            ),
            ListItem(
              title: "Gestion des groupes",
              subtitle: "Gérer les groupes d'utilisateurs",
              onTap: () => QR.to(AdminRouter.root + AdminRouter.usersGroups),
            ),
            ListItem(
              title: "Notifications de groupe",
              subtitle: "Gérer les notifications pour les groupes",
              onTap: () =>
                  QR.to(AdminRouter.root + AdminRouter.groupNotification),
            ),
            Text(
              "Module de paiement",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ListItem(
              title: "Paiement",
              subtitle: "Gérer les structures du module de paiement",
              onTap: () => QR.to(AdminRouter.root + AdminRouter.structures),
            ),
            Text("Adhésion", style: Theme.of(context).textTheme.titleLarge),
            ListItem(
              title: "Adhésion",
              subtitle: "Gérer les adhésions des utilisateurs",
              onTap: () =>
                  QR.to(AdminRouter.root + AdminRouter.associationMemberships),
            ),
          ],
        ),
      ),
    );
  }
}

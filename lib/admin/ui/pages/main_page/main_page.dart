import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/router.dart';
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
            ListItem(
              title: "Gestion des utilisateurs",
              subtitle: "Gérer les utilisateurs de l'application",
              onTap: () =>
                  QR.to(AdminRouter.root + AdminRouter.usersManagement),
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
          ],
        ),
      ),
    );
  }
}

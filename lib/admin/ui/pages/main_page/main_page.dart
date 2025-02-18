import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/pages/main_page/menu_card_ui.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminMainPage extends HookConsumerWidget {
  const AdminMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userList);

    final controller = ScrollController();

    return AdminTemplate(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: GridView(
          controller: controller,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height
                ? 0.75
                : 1.5,
          ),
          children: [
            GestureDetector(
              onTap: () {
                QR.to(
                  AdminRouter.root + AdminRouter.editModuleVisibility,
                );
              },
              child: const MenuCardUi(
                text: AdminTextConstants.visibilities,
                icon: HeroIcons.eye,
              ),
            ),
            GestureDetector(
              onTap: () {
                QR.to(AdminRouter.root + AdminRouter.groups);
              },
              child: const MenuCardUi(
                text: AdminTextConstants.groups,
                icon: HeroIcons.users,
              ),
            ),
            GestureDetector(
              onTap: () {
                QR.to(AdminRouter.root + AdminRouter.schools);
              },
              child: const MenuCardUi(
                text: AdminTextConstants.schools,
                icon: HeroIcons.academicCap,
              ),
            ),
            GestureDetector(
              onTap: () {
                QR.to(AdminRouter.root + AdminRouter.schools);
              },
              child: const MenuCardUi(
                text: AdminTextConstants.myEclPay,
                icon: HeroIcons.creditCard,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

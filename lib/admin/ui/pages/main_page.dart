import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/ui/admin.dart';
import 'package:titan/admin/ui/components/menu_card_ui.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminMainPage extends HookConsumerWidget {
  const AdminMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isAdminProvider);
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
            childAspectRatio:
                MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height
                ? 0.75
                : 1.5,
          ),
          children: [
            if (isAdmin) ...[
              MenuCardUi(
                text: AdminTextConstants.permissions,
                icon: HeroIcons.lockOpen,
                onTap: () {
                  QR.to(AdminRouter.root + AdminRouter.permissions);
                },
              ),
              MenuCardUi(
                text: AdminTextConstants.groups,
                icon: HeroIcons.users,
                onTap: () {
                  QR.to(AdminRouter.root + AdminRouter.groups);
                },
              ),
              MenuCardUi(
                text: AdminTextConstants.schools,
                icon: HeroIcons.academicCap,
                onTap: () {
                  QR.to(AdminRouter.root + AdminRouter.schools);
                },
              ),
              MenuCardUi(
                text: AdminTextConstants.myPayment,
                icon: HeroIcons.creditCard,
                onTap: () {
                  QR.to(AdminRouter.root + AdminRouter.structures);
                },
              ),
            ],
            MenuCardUi(
              text: AdminTextConstants.memberships,
              icon: HeroIcons.link,
              onTap: () {
                QR.to(AdminRouter.root + AdminRouter.associationMemberships);
              },
            ),
          ],
        ),
      ),
    );
  }
}

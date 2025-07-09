import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/admin/ui/admin.dart';
import 'package:titan/admin/ui/pages/main_page/menu_card_ui.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

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
            childAspectRatio:
                MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height
                ? 0.75
                : 1.5,
          ),
          children: [
            GestureDetector(
              onTap: () {
                QR.to(AdminRouter.root + AdminRouter.editModuleVisibility);
              },
              child: MenuCardUi(
                text: AppLocalizations.of(context)!.adminVisibilities,
                icon: HeroIcons.eye,
              ),
            ),
            GestureDetector(
              onTap: () {
                QR.to(AdminRouter.root + AdminRouter.groups);
              },
              child: MenuCardUi(
                text: AppLocalizations.of(context)!.adminGroups,
                icon: HeroIcons.users,
              ),
            ),
            GestureDetector(
              onTap: () {
                QR.to(AdminRouter.root + AdminRouter.schools);
              },
              child: MenuCardUi(
                text: AppLocalizations.of(context)!.adminSchools,
                icon: HeroIcons.academicCap,
              ),
            ),
            GestureDetector(
              onTap: () {
                QR.to(AdminRouter.root + AdminRouter.structures);
              },
              child: MenuCardUi(
                text: AppLocalizations.of(context)!.adminMyEclPay,
                icon: HeroIcons.creditCard,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

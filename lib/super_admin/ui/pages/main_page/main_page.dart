import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/router.dart';
import 'package:titan/super_admin/ui/admin.dart';
import 'package:titan/super_admin/ui/pages/main_page/menu_card_ui.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class SuperAdminMainPage extends HookConsumerWidget {
  const SuperAdminMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userList);

    final controller = ScrollController();

    return SuperAdminTemplate(
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
                QR.to(
                  SuperAdminRouter.root + SuperAdminRouter.editModuleVisibility,
                );
              },
              child: MenuCardUi(
                text: AppLocalizations.of(context)!.adminVisibilities,
                icon: HeroIcons.eye,
              ),
            ),
            GestureDetector(
              onTap: () {
                QR.to(SuperAdminRouter.root + SuperAdminRouter.schools);
              },
              child: MenuCardUi(
                text: AppLocalizations.of(context)!.adminSchools,
                icon: HeroIcons.academicCap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

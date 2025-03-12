import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/tools/functions.dart';
import 'package:myecl/seed-library/providers/information_provider.dart';
import 'package:myecl/seed-library/router.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/seed-library/ui/pages/main_page/menu_card_ui.dart';
import 'package:myecl/seed-library/ui/seed_library.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SeedLibraryMainPage extends HookConsumerWidget {
  const SeedLibraryMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final information = ref.watch(syncInformationProvider);

    final controller = ScrollController();

    return SeedLibraryTemplate(
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
                  SeedLibraryRouter.root + SeedLibraryRouter.plants,
                );
              },
              child: const MenuCardUi(
                text: SeedLibraryTextConstants.myPlants,
                icon: HeroIcons.magnifyingGlass,
              ),
            ),
            GestureDetector(
              onTap: () {
                QR.to(SeedLibraryRouter.root + SeedLibraryRouter.stock);
              },
              child: const MenuCardUi(
                text: SeedLibraryTextConstants.stock,
                icon: HeroIcons.inboxStack,
              ),
            ),
            GestureDetector(
              onTap: () {
                QR.to(SeedLibraryRouter.root + SeedLibraryRouter.seedDeposit);
              },
              child: const MenuCardUi(
                text: SeedLibraryTextConstants.seedDeposit,
                icon: HeroIcons.inboxArrowDown,
              ),
            ),
            GestureDetector(
              onTap: () {
                openLink(information.facebookUrl);
              },
              child: const MenuCardUi(
                text: SeedLibraryTextConstants.helpSheets,
                icon: HeroIcons.documentMagnifyingGlass,
              ),
            ),
            GestureDetector(
              onTap: () {
                openLink(information.forumUrl);
              },
              child: const MenuCardUi(
                text: SeedLibraryTextConstants.forum,
                icon: HeroIcons.fire,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

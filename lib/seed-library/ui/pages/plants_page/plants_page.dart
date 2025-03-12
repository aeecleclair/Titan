// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:heroicons/heroicons.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:myecl/centralisation/tools/functions.dart';
// import 'package:myecl/seed-library/providers/information_provider.dart';
// import 'package:myecl/seed-library/router.dart';
// import 'package:myecl/seed-library/tools/constants.dart';
// import 'package:myecl/seed-library/ui/pages/main_page/menu_card_ui.dart';
// import 'package:myecl/seed-library/ui/seed_library.dart';
// import 'package:qlevar_router/qlevar_router.dart';

// class StockPage extends HookConsumerWidget {
//   const StockPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final information = ref.watch(syncInformationProvider);

//     final controller = ScrollController();

//     return SeedLibraryTemplate(
//       child: Padding(
//         padding: const EdgeInsets.all(40),
//         child: GridView(
//           controller: controller,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 20,
//             crossAxisSpacing: 20,
//             childAspectRatio: MediaQuery.of(context).size.width <
//                     MediaQuery.of(context).size.height
//                 ? 0.75
//                 : 1.5,
//           ),
//           children: [
//             GestureDetector(
//               onTap: () {
//                 QR.to(
//                   SeedLibraryRouter.root +
//                       SeedLibraryRouter.stock +
//                       SeedLibraryRouter.loanDetail,
//                 );
//               },
//               child: const MenuCardUi(
//                 text: SeedLibraryTextConstants.myPlants,
//                 icon: HeroIcons.inboxStack,
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 QR.to(SeedLibraryRouter.root +
//                     SeedLibraryRouter.stock +
//                     SeedLibraryRouter.loanDetail);
//               },
//               child: const MenuCardUi(
//                 text: SeedLibraryTextConstants.stock,
//                 icon: HeroIcons.inboxStack,
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 QR.to(SeedLibraryRouter.root +
//                     SeedLibraryRouter.stock +
//                     SeedLibraryRouter.loanDetail);
//               },
//               child: const MenuCardUi(
//                 text: SeedLibraryTextConstants.seedDeposit,
//                 icon: HeroIcons.inboxArrowDown,
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 openLink(information.facebookUrl);
//               },
//               child: const MenuCardUi(
//                 text: SeedLibraryTextConstants.helpSheets,
//                 icon: HeroIcons.inboxArrowDown,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/is_admin_provider.dart';
import 'package:myecl/centralisation/tools/functions.dart';
import 'package:myecl/seed-library/providers/is_seed_library_admin_provider.dart';
import 'package:myecl/seed-library/router.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/seed-library/ui/pages/stock_page/research_bar.dart';
import 'package:myecl/seed-library/ui/seed_library.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class StockPage extends HookConsumerWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSeedLibraryAdmin = ref.watch(isSeedLibraryAdminProvider);
    final isAdmin = ref.watch(isAdminProvider);
    final plantNotifier = ref.watch(plantProvider.notifier);
    final plantListNotifier = ref.watch(plantListProvider.notifier);
    final plantList = ref.watch(plantListProvider);
    final plantFilteredList = ref.watch(plantFilteredListProvider);
    final plantKindsNotifier = ref.watch(plantKindsProvider.notifier);
    final kindNotifier = ref.watch(plantKindProvider.notifier);

    return SeedLibraryTemplate(
        child: Refresher(
            onRefresh: () async {
              await plantKindsNotifier.loadPlantKinds();
              await plantListNotifier.loadPlants();
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      const ResearchBar(),
                      if (isSeedLibraryAdmin || isAdmin)
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: AdminButton(
                            onTap: () {
                              kindNotifier.setKind('');
                              QR.to(SeedLibraryRouter.root +
                                  SeedLibraryRouter.admin);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ...plantFilteredList.map(
                  (plant) => !plant.deactivated
                      ? PlantCard(
                          plant: plant,
                          onClicked: () {
                            plantNotifier.setPlant(plant);
                            openLink(information.facebookUrl);
                          },
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            )));
  }
}

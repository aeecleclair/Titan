<<<<<<< Updated upstream
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/booking/providers/is_admin_provider.dart';
=======
import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/booking/providers/is_admin_provider.dart';
import 'package:titan/shotgun/ui/components/shotgun_card.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
>>>>>>> Stashed changes
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/tools/ui/layouts/column_refresher.dart';
import 'package:titan/shotgun/router.dart';
import 'package:titan/shotgun/providers/is_shotgun_admin_provider.dart';
<<<<<<< Updated upstream
import 'package:titan/shotgun/ui/pages/main_page/main_page.dart';
=======
import 'package:titan/shotgun/providers/shotgun_list_provider.dart';
import 'package:titan/shotgun/providers/shotgun_provider.dart';
import 'package:titan/shotgun/ui/pages/main_page/main_page.dart';
import 'package:titan/shotgun/ui/components/announcer_bar.dart';
>>>>>>> Stashed changes
import 'package:titan/shotgun/tools/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ShotgunMainPage extends HookConsumerWidget {
  const ShotgunMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isShotgunAdmin = ref.watch(isShotgunAdminProvider);
    final isAdmin = ref.watch(isAdminProvider);
<<<<<<< Updated upstream
=======

    final shotgunNotifier = ref.watch(shotgunProvider.notifier);
    final shotgunList = ref.watch(shotgunListProvider);
    final shotgunListNotifier = ref.watch(shotgunListProvider.notifier);
    final selected = ref.watch(announcerProvider);
    final selectedNotifier = ref.watch(announcerProvider.notifier);

>>>>>>> Stashed changes
    double width = 300;
    double height = 300;
    double imageHeight = 175;
    double maxHeight = MediaQuery.of(context).size.height - 344;

<<<<<<< Updated upstream
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopBar(title: 'Shotgun', root: ShotgunRouter.root),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
=======
    return ShotgunTemplate(
      child: Stack(
        children: [
          AsyncChild(
            value: shotgunList,
            builder: (context, shotgunData) {
              final sortedShotgunData = shotgunData
                  .sortedBy((element) => element.date)
                  .reversed;
              final filteredSortedShotgunData = sortedShotgunData.where(
                (shotgun) =>
                    selected
                        .where((e) => shotgun.announcer.name == e.name)
                        .isNotEmpty ||
                    selected.isEmpty,
              );
              return ColumnRefresher(
                onRefresh: () async {
                  await shotgunListNotifier.loadShotguns();
                },
                children: [
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
>>>>>>> Stashed changes
                      children: [
                        if (isAdmin)
                          AdminButton(
                            onTap: () {
                              QR.to(ShotgunRouter.root + ShotgunRouter.admin);
                            },
                          ),
<<<<<<< Updated upstream
                        // if (isShotgunAdmin)
                        //   AdminButton(
                        //     onTap: () {
                        //       QR.to(
                        //         ShotgunRouter.root +
                        //             ShotgunRouter.addEditMember,
                        //       );
                        //     },
                        //     text: ShotgunTextConstants.management,
                        //   ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            ShotgunTextConstants.news,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
=======
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AnnouncerBar(
                    useUserAnnouncers: false,
                    multipleSelect: true,
                  ),
                  const SizedBox(height: 20),
                  ...filteredSortedShotgunData.map(
                    (shotgun) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ShotgunCard(
                        onTap: () {
                          shotgunNotifier.setShotgun(shotgun);
                          QR.to(ShotgunRouter.root + ShotgunRouter.admin);
                        },
                        shotgun: shotgun,
>>>>>>> Stashed changes
                      ),
                    ),
                  ),
                ],
<<<<<<< Updated upstream
              ),
            ),
          ),
        ],
=======
              );
            },
          ),
        ],  
>>>>>>> Stashed changes
      ),
    );
  }
}
<<<<<<< Updated upstream
=======
//     SafeArea(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           TopBar(title: 'Shotgun', root: ShotgunRouter.root),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: width,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [

//                         // if (isShotgunAdmin)
//                         //   AdminButton(
//                         //     onTap: () {
//                         //       QR.to(
//                         //         ShotgunRouter.root +
//                         //             ShotgunRouter.addEditMember,
//                         //       );
//                         //     },
//                         //     text: ShotgunTextConstants.management,
//                         //   ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             ShotgunTextConstants.news,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
>>>>>>> Stashed changes

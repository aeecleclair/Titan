import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/pages/main_page/settings_item.dart';
import 'package:myecl/settings/ui/refresh_indicator.dart';
import 'package:myecl/user/providers/user_provider.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
    final meNotifier = ref.watch(asyncUserProvider.notifier);
    final pageNotifier = ref.watch(settingsPageProvider.notifier);
    return SettingsRefresher(
      onRefresh: () async {
        await meNotifier.loadMe();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(SettingsTextConstants.settings,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Compte",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
            const SizedBox(
              height: 30,
            ),
            SettingsItem(
              icon: HeroIcons.user,
              onTap: () {
                pageNotifier.setSettingsPage(SettingsPage.info);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(me.nickname != "" ? me.nickname : me.firstname,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("${me.firstname} ${me.name}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(SettingsTextConstants.settings,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
            const SizedBox(
              height: 30,
            ),
            SettingsItem(
              icon: HeroIcons.bell,
              onTap: () {},
              child: const Text("Notifications",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black)),
            ),
            const SizedBox(
              height: 30,
            ),
            SettingsItem(
              icon: HeroIcons.shieldCheck,
              onTap: () {},
              child: const Text("Securité",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black)),
            ),
            const SizedBox(
              height: 30,
            ),
            SettingsItem(
              icon: HeroIcons.moon,
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Mode sombre",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black)),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text("Désactivé",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500])),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SettingsItem(
              icon: HeroIcons.language,
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Langue",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black)),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text("Français",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500])),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SettingsItem(
              icon: HeroIcons.lifebuoy,
              onTap: () {},
              child: const Text("Aide",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black)),
            ),
          ]),
        ),
        //   padding: const EdgeInsets.all(20.0),
        //   child: Column(
        //     children: [
        //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //         Expanded(
        //           child: Column(children: [
        //             Text(
        //               me.nickname,
        //               style: const TextStyle(
        //                 fontSize: 30,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             const SizedBox(height: 10),
        //             Text(
        //               "${me.firstname} ${me.name}",
        //               style: const TextStyle(
        //                 fontSize: 20,
        //               ),
        //             ),
        //           ]),
        //         ),
        //         SizedBox(
        //             width: 100,
        //             child: GestureDetector(
        //               onTap: () {
        //                 pageNotifier.setSettingsPage(SettingsPage.info);
        //               },
        //               child: Center(
        //                 child: Stack(
        //                     clipBehavior: Clip.none,
        //                     alignment: Alignment.center,
        //                     children: [
        //                       Transform.rotate(
        //                         angle: 3.14 / 12,
        //                         child: Container(
        //                             width: 50,
        //                             height: 50,
        //                             decoration: BoxDecoration(
        //                               gradient:  const LinearGradient(
        //                                 colors: [
        //                                   SettingsColorConstants.gradient1,
        //                                   SettingsColorConstants.gradient2,
        //                                 ],
        //                               ),
        //                               boxShadow: [
        //                                 BoxShadow(
        //                                   color: SettingsColorConstants
        //                                       .gradient2
        //                                       .withOpacity(0.5),
        //                                   blurRadius: 5,
        //                                   offset: const Offset(2, 2),
        //                                   spreadRadius: 2,
        //                                 ),
        //                               ],
        //                               borderRadius: BorderRadius.circular(15),
        //                             )),
        //                       ),
        //                       Positioned(
        //                         top: 5,
        //                         right: 7,
        //                         child: ClipRRect(
        //                           borderRadius: const BorderRadius.all(
        //                               Radius.circular(15)),
        //                           child: BackdropFilter(
        //                               filter: ImageFilter.blur(
        //                                   sigmaX: 10.0, sigmaY: 10.0),
        //                               child: Container(
        //                                   decoration: BoxDecoration(
        //                                     borderRadius:
        //                                         BorderRadius.circular(15),
        //                                     border: Border.all(
        //                                       color: Colors.white,
        //                                       width: 1,
        //                                     ),
        //                                   ),
        //                                   width: 50,
        //                                   height: 50,
        //                                   child: const Icon(
        //                                     Icons.edit,
        //                                     color: Colors.white,
        //                                   ))),
        //                         ),
        //                       )
        //                     ]),
        //               ),
        //             )),
        //       ]),
        //       const SizedBox(
        //         height: 50,
        //       ),
        //       GestureDetector(
        //         child: Container(
        //           width: double.infinity,
        //           height: 50,
        //           decoration: BoxDecoration(
        //             gradient:  const LinearGradient(
        //               colors: [
        //                 SettingsColorConstants.gradient1,
        //                 SettingsColorConstants.gradient2,
        //               ],
        //             ),
        //             boxShadow: [
        //               BoxShadow(
        //                 color: SettingsColorConstants.gradient2.withOpacity(0.5),
        //                 blurRadius: 5,
        //                 offset: const Offset(2, 2),
        //                 spreadRadius: 2,
        //               ),
        //             ],
        //             borderRadius: BorderRadius.circular(15),
        //           ),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: const [
        //               Text(
        //                 "Changer de mot de passe",
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 20,
        //                 ),
        //               ),
        //               HeroIcon(
        //                 HeroIcons.lockClosed,
        //                 color: Colors.white,
        //               ),
        //             ],
        //           ),
        //         ),
        //         onTap: () {
        //           pageNotifier.setSettingsPage(SettingsPage.changePass);
        //         },
        //       ),
        //       const SizedBox(
        //         height: 50,
        //       ),
        //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //         const Text(
        //           SettingsTextConstants.email,
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //           ),
        //         ),
        //         Text(
        //           me.email,
        //           style: const TextStyle(
        //             fontSize: 18,
        //           ),
        //         ),
        //       ]),
        //       const SizedBox(height: 25),
        //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //         const Text(
        //           SettingsTextConstants.promo,
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //           ),
        //         ),
        //         Text(
        //           me.promo.toString(),
        //           style: const TextStyle(
        //             fontSize: 18,
        //           ),
        //         ),
        //       ]),
        //       const SizedBox(height: 25),
        //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //         const Text(
        //           SettingsTextConstants.floor,
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //           ),
        //         ),
        //         Text(
        //           me.floor.toString(),
        //           style: const TextStyle(
        //             fontSize: 18,
        //           ),
        //         ),
        //       ]),
        //       const SizedBox(height: 25),
        //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //         const Text(
        //           SettingsTextConstants.birthday,
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //           ),
        //         ),
        //         Text(
        //           processDatePrint(me.birthday),
        //           style: const TextStyle(
        //             fontSize: 18,
        //           ),
        //         ),
        //       ]),
        //       const SizedBox(height: 25),
        //       me.groups.isNotEmpty
        //           ? Column(children: [
        //               Container(
        //                   alignment: Alignment.centerLeft,
        //                   child: Text(
        //                     SettingsTextConstants.association +
        //                         (me.groups.length > 1 ? "s" : ""),
        //                     style: const TextStyle(
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: 18,
        //                     ),
        //                   )),
        //               ...me.groups.map((e) => Column(
        //                     children: [
        //                       const SizedBox(height: 15),
        //                       Text(
        //                         "- ${capitalize(e.name)}",
        //                         style: const TextStyle(
        //                           fontSize: 18,
        //                         ),
        //                       ),
        //                     ],
        //                   ))
        //             ])
        //           : Container(),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

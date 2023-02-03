import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/providers/logs_provider.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/pages/main_page/settings_item.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/user/repositories/profile_picture_repository.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
    final meNotifier = ref.watch(asyncUserProvider.notifier);
    final pageNotifier = ref.watch(settingsPageProvider.notifier);
    final titanVersion = ref.watch(titanVersionProvider);
    final profilePicture = ref.watch(profilePictureProvider);
    ref.watch(logsProvider.notifier).getLogs();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Refresher(
        onRefresh: () async {
          await meNotifier.loadMe();
        },
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
          profilePicture.when(data: (profile) {
            return Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 6,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: Image.memory(profile).image,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: -MediaQuery.of(context).size.width / 2 + 70,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 125,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(-2, -3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (me.nickname.isNotEmpty)
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      me.nickname,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                me.nickname != null
                                    ? "${me.firstname} ${me.name}"
                                    : me.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, error: (e, s) {
            return const HeroIcon(
              HeroIcons.userCircle,
              size: 140,
            );
          }),
          const SizedBox(
            height: 100,
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              const SizedBox(
                width: 15,
              ),
              ...me.groups
                  .map(
                    (e) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Chip(
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                capitalize(e.name),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            backgroundColor: Colors.black)),
                  )
                  .toList(),
              const SizedBox(
                width: 15,
              )
            ]),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(SettingsTextConstants.account,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                const SizedBox(
                  height: 30,
                ),
                SettingsItem(
                  icon: HeroIcons.pencil,
                  onTap: () {
                    pageNotifier.setSettingsPage(SettingsPage.edit);
                  },
                  child: const Text(SettingsTextConstants.editAccount,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                const SizedBox(
                  height: 30,
                ),
                SettingsItem(
                  icon: HeroIcons.calendarDays,
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                            text: "${Repository.displayHost}calendar/ical"))
                        .then((value) {
                      displayToastWithContext(
                          TypeMsg.msg, SettingsTextConstants.icalCopied);
                    });
                  },
                  child: const Text(SettingsTextConstants.eventsIcal,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(SettingsTextConstants.security,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                const SizedBox(
                  height: 30,
                ),
                SettingsItem(
                  icon: HeroIcons.lockClosed,
                  onTap: () {
                    pageNotifier.setSettingsPage(SettingsPage.changePassword);
                  },
                  child: const Text(SettingsTextConstants.editPassword,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(SettingsTextConstants.help,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                // SettingsItem(
                //   icon: HeroIcons.chatBubbleLeftRight,
                //   onTap: () {
                //     // pageNotifier.setSettingsPage(SettingsPage.help);
                //   },
                //   child: const Text(SettingsTextConstants.askHelp,
                //       style: TextStyle(fontSize: 16, color: Colors.black)),
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                // SettingsItem(
                //   icon: HeroIcons.bugAnt,
                //   onTap: () {
                //     BetterFeedback.of(context).show(
                //       (UserFeedback feedback) async {
                //         final screenshotFilePath =
                //             await writeImageToStorage(feedback.screenshot);

                //         await Share.shareXFiles(
                //           [XFile(screenshotFilePath)],
                //           text: feedback.text,
                //         );
                //       },
                //     );
                //   },
                //   child: const Text(SettingsTextConstants.repportBug,
                //       style: TextStyle(fontSize: 16, color: Colors.black)),
                // ),
                const SizedBox(
                  height: 30,
                ),
                SettingsItem(
                  icon: HeroIcons.clipboardDocumentList,
                  onTap: () {
                    pageNotifier.setSettingsPage(SettingsPage.logs);
                  },
                  child: const Text(SettingsTextConstants.logs,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(SettingsTextConstants.personalisation,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                // SettingsItem(
                //   icon: HeroIcons.bellAlert,
                //   onTap: () {
                //     // pageNotifier.setSettingsPage(SettingsPage.help);
                //   },
                //   child: const Text(SettingsTextConstants.notifications,
                //       style: TextStyle(fontSize: 16, color: Colors.black)),
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                // SettingsItem(
                //   icon: HeroIcons.moon,
                //   onTap: () {
                //     // pageNotifier.setSettingsPage(SettingsPage.help);
                //   },
                //   child: const Text(SettingsTextConstants.darkMode,
                //       style: TextStyle(fontSize: 16, color: Colors.black)),
                // ),
                const SizedBox(
                  height: 30,
                ),
                SettingsItem(
                  icon: HeroIcons.queueList,
                  onTap: () {
                    pageNotifier.setSettingsPage(SettingsPage.modules);
                  },
                  child: const Text(SettingsTextConstants.modules,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(SettingsTextConstants.personalData,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                const SizedBox(
                  height: 30,
                ),
                SettingsItem(
                  icon: HeroIcons.circleStack,
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: SettingsTextConstants.detelePersonalData,
                            descriptions:
                                SettingsTextConstants.detelePersonalDataDesc,
                            onYes: () async {
                              final value = await meNotifier.deletePersonal();
                              if (value) {
                                displayToastWithContext(TypeMsg.msg,
                                    SettingsTextConstants.sendedDemand);
                              } else {
                                displayToastWithContext(TypeMsg.error,
                                    SettingsTextConstants.errorSendingDemand);
                              }
                            },
                          );
                        });
                  },
                  child: const Text(SettingsTextConstants.detelePersonalData,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${SettingsTextConstants.version} $titanVersion",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      const Text(SettingsTextConstants.hyperionUrl,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ]),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ]));
  }
}

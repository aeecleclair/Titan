import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/flappybird/ui/flappybird_item_chip.dart';
import 'package:titan/settings/providers/logs_provider.dart';
import 'package:titan/settings/router.dart';
import 'package:titan/settings/ui/pages/main_page/settings_item.dart';
import 'package:titan/settings/ui/settings.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/user/providers/profile_picture_provider.dart';
import 'package:titan/version/providers/titan_version_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class SettingsMainPage extends HookConsumerWidget {
  const SettingsMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
    final meNotifier = ref.watch(asyncUserProvider.notifier);
    final titanVersion = ref.watch(titanVersionProvider);
    final profilePicture = ref.watch(profilePictureProvider);
    ref.watch(logsProvider.notifier).getLogs();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SettingsTemplate(
      child: Refresher(
        onRefresh: () async {
          await meNotifier.loadMe();
        },
        child: Column(
          children: [
            const SizedBox(height: 25),
            AsyncChild(
              value: profilePicture,
              builder: (context, profile) {
                return Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              spreadRadius: 6,
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: profile.isEmpty
                              ? AssetImage(getTitanLogo())
                              : Image.memory(profile).image,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: -MediaQuery.of(context).size.width / 2 + 70,
                        child: Column(
                          children: [
                            const SizedBox(height: 125),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(-2, -3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        me.nickname ?? me.firstname,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    me.nickname != null
                                        ? "${me.firstname} ${me.name}"
                                        : me.name,
                                    style: const TextStyle(fontSize: 20),
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
              },
              errorBuilder: (e, s) =>
                  const HeroIcon(HeroIcons.userCircle, size: 140),
            ),
            const SizedBox(height: 100),
            HorizontalListView.builder(
              height: 40,
              items: me.groups,
              itemBuilder: (context, item, i) => ItemChip(
                selected: true,
                child: Text(
                  capitalize(item.name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              lastChild: const FlappyBirdItemChip(),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  AlignLeftText(
                    AppLocalizations.of(context)!.settingsAccount,
                    fontSize: 25,
                  ),
                  const SizedBox(height: 30),
                  SettingsItem(
                    icon: HeroIcons.pencil,
                    onTap: () {
                      QR.to(SettingsRouter.root + SettingsRouter.editAccount);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.settingsEditAccount,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SettingsItem(
                    icon: HeroIcons.calendarDays,
                    onTap: () {
                      final icalCopiedMsg = AppLocalizations.of(
                        context,
                      )!.settingsIcalCopied;
                      Clipboard.setData(
                        ClipboardData(text: "${Repository.host}calendar/ical"),
                      ).then((value) {
                        displayToastWithContext(TypeMsg.msg, icalCopiedMsg);
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!.settingsEventsIcal,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 50),
                  AlignLeftText(
                    AppLocalizations.of(context)!.settingsSecurity,
                    fontSize: 25,
                  ),
                  const SizedBox(height: 30),
                  SettingsItem(
                    icon: HeroIcons.lockClosed,
                    onTap: () {
                      QR.to(
                        SettingsRouter.root + SettingsRouter.changePassword,
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.settingsEditPassword,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 50),
                  if (!kIsWeb) ...[
                    AlignLeftText(
                      AppLocalizations.of(context)!.settingsHelp,
                      fontSize: 25,
                    ),
                    const SizedBox(height: 30),
                    SettingsItem(
                      icon: HeroIcons.clipboardDocumentList,
                      onTap: () {
                        QR.to(SettingsRouter.root + SettingsRouter.logs);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.settingsLogs,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                  AlignLeftText(
                    AppLocalizations.of(context)!.settingsPersonalisation,
                    fontSize: 25,
                  ),
                  const SizedBox(height: 30),
                  SettingsItem(
                    icon: HeroIcons.queueList,
                    onTap: () {
                      QR.to(SettingsRouter.root + SettingsRouter.modules);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.settingsModules,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SettingsItem(
                    icon: HeroIcons.bellAlert,
                    onTap: () {
                      QR.to(SettingsRouter.root + SettingsRouter.notifications);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.settingsNotifications,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 50),
                  AlignLeftText(
                    AppLocalizations.of(context)!.settingsPersonalData,
                    fontSize: 25,
                  ),
                  const SizedBox(height: 30),
                  SettingsItem(
                    icon: HeroIcons.circleStack,
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: AppLocalizations.of(
                              context,
                            )!.settingsDetelePersonalData,
                            descriptions: AppLocalizations.of(
                              context,
                            )!.settingsDetelePersonalDataDesc,
                            onYes: () async {
                              final sendedDemandMsg = AppLocalizations.of(
                                context,
                              )!.settingsSendedDemand;
                              final errorSendingDemandMsg = AppLocalizations.of(
                                context,
                              )!.settingsErrorSendingDemand;
                              final value = await meNotifier.deletePersonal();
                              if (value) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  sendedDemandMsg,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  errorSendingDemandMsg,
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.settingsDetelePersonalData,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    "${AppLocalizations.of(context)!.settingsVersion} $titanVersion",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AutoSizeText(
                    Repository.host,
                    maxLines: 1,
                    minFontSize: 10,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

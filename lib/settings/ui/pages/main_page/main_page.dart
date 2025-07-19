import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:load_switch/load_switch.dart';
import 'package:titan/settings/providers/notification_topic_provider.dart';
import 'package:titan/settings/ui/pages/main_page/change_pass.dart';

import 'package:titan/settings/ui/settings.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/locale_notifier.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';

class SettingsMainPage extends HookConsumerWidget {
  const SettingsMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final notificationTopicListNotifier = ref.watch(
      notificationTopicListProvider.notifier,
    );

    return SettingsTemplate(
      child: Refresher(
        onRefresh: () async {
          await notificationTopicListNotifier.loadNotificationTopicList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Paramètres",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),
              const SizedBox(height: 20),
              ListItem(
                title: "Langue",
                subtitle: ref.watch(localeProvider)?.languageCode,
                onTap: () async {
                  await showCustomBottomModal(
                    modal: BottomModalTemplate(
                      title: 'Choix de la langue',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListItemTemplate(
                            title: "🇫🇷 Français",
                            onTap: () async {
                              Navigator.of(context).pop();
                              await ref
                                  .read(localeProvider.notifier)
                                  .setLocale(const Locale('fr'));
                            },
                            trailing:
                                ref.watch(localeProvider)?.languageCode == 'fr'
                                ? const HeroIcon(
                                    HeroIcons.check,
                                    color: ColorConstants.tertiary,
                                  )
                                : Container(),
                          ),
                          ListItemTemplate(
                            title: "🇬🇧 English",
                            onTap: () async {
                              Navigator.of(context).pop();
                              await ref
                                  .read(localeProvider.notifier)
                                  .setLocale(const Locale('en'));
                            },
                            trailing:
                                ref.watch(localeProvider)?.languageCode == 'en'
                                ? const HeroIcon(
                                    HeroIcons.check,
                                    color: ColorConstants.tertiary,
                                  )
                                : Container(),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    context: context,
                    ref: ref,
                  );
                },
              ),
              ListItem(
                title: "Notifications",
                subtitle: "2/3 activées",
                onTap: () async {
                  await showCustomBottomModal(
                    modal: BottomModalTemplate(
                      title: 'Notifications',
                      child: Consumer(
                        builder: (context, ref, child) {
                          final notificationTopicList = ref.watch(
                            notificationTopicListProvider,
                          );
                          return AsyncChild(
                            value: notificationTopicList,
                            builder: (context, notificationTopicList) {
                              return Column(
                                children: [
                                  ...notificationTopicList.map(
                                    (notificationTopic) => ListItemTemplate(
                                      title: notificationTopic.name,
                                      trailing: LoadSwitch(
                                        value:
                                            notificationTopic.isUserSubscribed,
                                        future: () async {
                                          await notificationTopicListNotifier
                                              .toggleSubscription(
                                                notificationTopic,
                                              );
                                          return !notificationTopic
                                              .isUserSubscribed;
                                        },
                                        height: 30,
                                        width: 60,
                                        curveIn: Curves.easeInBack,
                                        curveOut: Curves.easeOutBack,
                                        animationDuration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        switchDecoration: (value, _) =>
                                            BoxDecoration(
                                              color: value
                                                  ? Colors.red.withValues(
                                                      alpha: 0.3,
                                                    )
                                                  : Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              shape: BoxShape.rectangle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: value
                                                      ? Colors.red.withValues(
                                                          alpha: 0.2,
                                                        )
                                                      : Colors.grey.withValues(
                                                          alpha: 0.2,
                                                        ),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                        spinColor: (value) =>
                                            value ? Colors.red : Colors.grey,
                                        spinStrokeWidth: 2,
                                        thumbDecoration: (value, _) =>
                                            BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              shape: BoxShape.rectangle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: value
                                                      ? Colors.red.withValues(
                                                          alpha: 0.2,
                                                        )
                                                      : Colors.grey.shade200
                                                            .withValues(
                                                              alpha: 0.2,
                                                            ),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                        onChange: (v) {},
                                        onTap: (v) {},
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    context: context,
                    ref: ref,
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Événement",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),
              ListItemTemplate(
                title: "Lien ical",
                subtitle: "Synchroniser avec votre calendrier",
                trailing: const HeroIcon(
                  HeroIcons.clipboardDocumentList,
                  color: ColorConstants.tertiary,
                ),
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: "${Repository.host}calendar/ical"),
                  ).then((value) {
                    displayToastWithContext(
                      TypeMsg.msg,
                      "Lien ical copié dans le presse-papiers",
                    );
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Profil",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),
              ListItem(
                title: "Mot de passe",
                subtitle: "Changer mon mot de passe",
                onTap: () async {
                  await showCustomBottomModal(
                    modal: BottomModalTemplate(
                      title: 'Mot de passe',
                      child: ChangePassPage(),
                    ),
                    context: context,
                    ref: ref,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

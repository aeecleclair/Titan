import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/settings/providers/notification_topic_provider.dart';
import 'package:titan/settings/tools/functions.dart';
import 'package:titan/settings/ui/pages/main_page/change_pass.dart';
import 'package:titan/settings/ui/pages/main_page/load_switch_topic.dart';

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
    final notificationTopicList = ref.watch(notificationTopicListProvider);

    final notificationAcivatedCounts = notificationTopicList.when(
      data: (data) => data.where((topic) => topic.isUserSubscribed).length,
      loading: () => 0,
      error: (_, _) => 0,
    );

    final notificationTopicsLength = notificationTopicList.when(
      data: (data) => data.length,
      loading: () => 0,
      error: (_, _) => 0,
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
                subtitle:
                    "$notificationAcivatedCounts/$notificationTopicsLength activées",
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
                              final notificationTopicsByModuleRoot =
                                  groupNotificationTopicsByModuleRoot(
                                    notificationTopicList,
                                  );
                              final uniqueTopics =
                                  notificationTopicsByModuleRoot[''] ?? [];
                              final groupedTopics = Map.from(
                                notificationTopicsByModuleRoot,
                              )..remove('');
                              return Column(
                                children: [
                                  ...uniqueTopics.map(
                                    (notificationTopic) => ListItemTemplate(
                                      title: notificationTopic.name,
                                      trailing: LoadSwitchTopic(
                                        notificationTopic: notificationTopic,
                                      ),
                                    ),
                                  ),
                                  ...groupedTopics.entries.map((entry) {
                                    final moduleRoot = entry.key;
                                    final topics = entry.value;
                                    bool expanded = false;
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            ListItemTemplate(
                                              title: moduleRoot,
                                              trailing: HeroIcon(
                                                expanded
                                                    ? HeroIcons.chevronDown
                                                    : HeroIcons.chevronRight,
                                                color: ColorConstants.tertiary,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  expanded = !expanded;
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            if (expanded)
                                              ...topics.map(
                                                (
                                                  notificationTopic,
                                                ) => ListItemTemplate(
                                                  title: notificationTopic.name,
                                                  trailing: LoadSwitchTopic(
                                                    notificationTopic:
                                                        notificationTopic,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
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

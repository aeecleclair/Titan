import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/service/providers/firebase_token_expiration_provider.dart';
import 'package:titan/service/providers/messages_provider.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/styleguide/confirm_modal.dart';
import 'package:titan/tools/ui/widgets/vertical_clip_scroll.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/settings/providers/notification_topic_provider.dart';
import 'package:titan/settings/tools/functions.dart';
import 'package:titan/settings/ui/pages/main_page/edit_profile.dart';
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
import 'package:titan/user/providers/profile_picture_provider.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/version/providers/titan_version_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsMainPage extends HookConsumerWidget {
  const SettingsMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titanVersion = ref.watch(titanVersionProvider);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final pathForwardingProviderNotifier = ref.read(
      pathForwardingProvider.notifier,
    );

    final notificationTopicListNotifier = ref.watch(
      notificationTopicListProvider.notifier,
    );
    final notificationTopicList = ref.watch(notificationTopicListProvider);
    final meNotifier = ref.watch(asyncUserProvider.notifier);
    final profilePicture = ref.watch(profilePictureProvider);
    final auth = ref.watch(authTokenProvider.notifier);
    final isCachingNotifier = ref.watch(isCachingProvider.notifier);

    final results = notificationTopicList.when(
      data: (data) {
        final activatedCount = data
            .where((topic) => topic.isUserSubscribed)
            .length;
        final totalCount = data.length;
        return {'activatedCount': activatedCount, 'totalCount': totalCount};
      },
      loading: () => {'activatedCount': 0, 'totalCount': 0},
      error: (_, _) => {'activatedCount': 0, 'totalCount': 0},
    );

    final notificationActivatedCounts = results['activatedCount']!;
    final notificationTopicsLength = results['totalCount']!;

    final localizeWithContext = AppLocalizations.of(context)!;

    final selectedLanguage = localizeWithContext.settingsLanguageVar;

    return SettingsTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await notificationTopicListNotifier.loadNotificationTopicList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                      ],
                    ),
                  );
                },
                errorBuilder: (e, s) =>
                    const HeroIcon(HeroIcons.userCircle, size: 140),
              ),
              const SizedBox(height: 20),
              Text(
                localizeWithContext.settingsAccount,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),
              ListItem(
                title: localizeWithContext.settingsProfile,
                subtitle: localizeWithContext.settingsEditAccount,
                onTap: () async {
                  await showCustomBottomModal(
                    modal: BottomModalTemplate(
                      title: localizeWithContext.settingsEditAccount,
                      child: EditProfile(),
                    ),
                    context: context,
                    ref: ref,
                  );
                },
              ),
              ListItem(
                title: localizeWithContext.settingsLanguage,
                subtitle: selectedLanguage,
                onTap: () async {
                  await showCustomBottomModal(
                    modal: BottomModalTemplate(
                      title: localizeWithContext.settingsChooseLanguage,
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
                          const SizedBox(height: 10),
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
                title: localizeWithContext.settingsNotifications,
                subtitle: localizeWithContext.settingsNotificationCounter(
                  notificationActivatedCounts,
                  notificationTopicsLength,
                ),
                onTap: () async {
                  await showCustomBottomModal(
                    modal: BottomModalTemplate(
                      title: localizeWithContext.settingsNotifications,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 600),
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
                                      ref,
                                      context,
                                    );
                                final uniqueTopics =
                                    notificationTopicsByModuleRoot['others'] ??
                                    [];
                                final groupedTopics = Map.from(
                                  notificationTopicsByModuleRoot,
                                )..remove('others');
                                return VerticalClipScroll(
                                  child: Column(
                                    children: [
                                      ...uniqueTopics.map(
                                        (notificationTopic) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: ListItemTemplate(
                                            title: notificationTopic.name,
                                            trailing: LoadSwitchTopic(
                                              notificationTopic:
                                                  notificationTopic,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ...groupedTopics.entries.map((entry) {
                                        final moduleRoot = entry.key;
                                        final topics = entry.value;
                                        bool expanded = true;
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 20),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                      ),
                                                  child: ListItemTemplate(
                                                    title: moduleRoot,
                                                    trailing: HeroIcon(
                                                      expanded
                                                          ? HeroIcons
                                                                .chevronDown
                                                          : HeroIcons
                                                                .chevronRight,
                                                      color: ColorConstants
                                                          .tertiary,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        expanded = !expanded;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                if (expanded)
                                                  ...topics.map(
                                                    (
                                                      notificationTopic,
                                                    ) => Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 8.0,
                                                          ),
                                                      child: ListItemTemplate(
                                                        title: notificationTopic
                                                            .name,
                                                        trailing: LoadSwitchTopic(
                                                          notificationTopic:
                                                              notificationTopic,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            );
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    context: context,
                    ref: ref,
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                localizeWithContext.settingsEvent,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),
              ListItemTemplate(
                title: localizeWithContext.settingsIcal,
                subtitle: localizeWithContext.settingsSynncWithCalendar,
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
                      localizeWithContext.settingsIcalCopied,
                    );
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                localizeWithContext.settingsConnexion,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),
              const SizedBox(height: 10),
              ListItem(
                title: localizeWithContext.settingsChangePassword,
                onTap: () async {
                  await launchUrl(
                    Uri.parse("${getTitanHost()}calypsso/change-password"),
                  );
                },
              ),
              const SizedBox(height: 10),
              ListItem(
                title: localizeWithContext.settingsLogOut,
                onTap: () async {
                  await showCustomBottomModal(
                    ref: ref,
                    context: context,
                    modal: ConfirmModal(
                      description:
                          localizeWithContext.settingsLogOutDescription,
                      title: localizeWithContext.settingsLogOut,
                      onYes: () {
                        auth.deleteToken();
                        if (!kIsWeb) {
                          ref.watch(messagesProvider.notifier).forgetDevice();
                          ref
                              .watch(firebaseTokenExpirationProvider.notifier)
                              .reset();
                        }
                        isCachingNotifier.set(false);
                        pathForwardingProviderNotifier.forward(FeedRouter.root);
                        displayToast(
                          context,
                          TypeMsg.msg,
                          localizeWithContext.settingsLogOutSuccess,
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              ListItem(
                title: localizeWithContext.settingsDeleteMyAccount,
                onTap: () async {
                  await showCustomBottomModal(
                    context: context,
                    ref: ref,
                    modal: ConfirmModal.danger(
                      description: localizeWithContext
                          .settingsDeleteMyAccountDescription,
                      title: localizeWithContext.settingsDeleteMyAccount,
                      onYes: () async {
                        final value = await meNotifier.deletePersonal();
                        if (value) {
                          displayToastWithContext(
                            TypeMsg.msg,
                            localizeWithContext.settingsDeletionAsked,
                          );
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            localizeWithContext.settingsDeleteMyAccountError,
                          );
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
              Text(
                "${localizeWithContext.othersVersion} $titanVersion",
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
      ),
    );
  }
}

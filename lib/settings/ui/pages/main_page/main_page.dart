import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/pages/main_page/settings_item.dart';
import 'package:myecl/settings/ui/refresh_indicator.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
    final meNotifier = ref.watch(asyncUserProvider.notifier);
    final pageNotifier = ref.watch(settingsPageProvider.notifier);
    final titanVersion = ref.watch(titanVersionProvider);
    return SettingsRefresher(
      onRefresh: () async {
        await meNotifier.loadMe();
      },
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
            onTap: () {
              pageNotifier.setSettingsPage(SettingsPage.notification);
            },
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
            onTap: () {
              pageNotifier.setSettingsPage(SettingsPage.security);
            },
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
          const SizedBox(
            height: 60,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Version $titanVersion",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            const Text("https://hyperion.myecl.fr",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ]),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}

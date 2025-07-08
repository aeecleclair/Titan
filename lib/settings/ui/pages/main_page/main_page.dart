import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/settings/ui/pages/main_page/change_pass.dart';

import 'package:titan/settings/ui/settings.dart';
import 'package:titan/tools/constants.dart';

import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';

import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/item_chip.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';

class SettingsMainPage extends HookConsumerWidget {
  const SettingsMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsTemplate(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              onFilter: () async {
                await showCustomBottomModal(
                  modal: BottomModalTemplate(
                    title: 'Filtrer',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Groupes d\'association'),
                        SizedBox(height: 10),
                        HorizontalListView(
                          height: 50,
                          children: [
                            ItemChip(child: Text('Option 1')),
                            ItemChip(child: Text('Option 2')),
                            ItemChip(child: Text('Option 3')),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text('Associations'),
                        SizedBox(height: 10),
                        HorizontalListView(
                          height: 50,
                          children: [
                            ItemChip(child: Text('Association 1')),
                            ItemChip(child: Text('Association 2')),
                            ItemChip(child: Text('Association 3')),
                          ],
                        ),
                        SizedBox(height: 40),
                        Button(
                          text: 'Appliquer',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  context: context,
                  ref: ref,
                );
              },
              onSearch: (_) {},
            ),
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
              subtitle: "Français",
              onTap: () async {
                await showCustomBottomModal(
                  modal: BottomModalTemplate(
                    title: 'Choix de la langue',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListItemTemplate(
                          title: "🇫🇷 Français",
                          trailing: Container(),
                        ),
                        ListItemTemplate(
                          title: "🇬🇧 English",
                          trailing: const HeroIcon(
                            HeroIcons.check,
                            color: ColorConstants.tertiary,
                          ),
                        ),
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
                bool showAnnonceDetails = false;
                await showCustomBottomModal(
                  modal: BottomModalTemplate(
                    title: 'Notifications',
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListItemTemplate(
                              title: "Feed",
                              trailing: Container(),
                            ),
                            ListItemTemplate(
                              title: "Campagnes",
                              trailing: const HeroIcon(
                                HeroIcons.check,
                                color: ColorConstants.tertiary,
                              ),
                            ),
                            ListItemTemplate(
                              title: "Annonces",
                              trailing: const HeroIcon(
                                HeroIcons.chevronDown,
                                color: ColorConstants.tertiary,
                              ),
                              onTap: () {
                                setState(() {
                                  showAnnonceDetails = !showAnnonceDetails;
                                });
                              },
                            ),
                            if (showAnnonceDetails) ...[
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListItemTemplate(
                                      title: "BDE",
                                      trailing: Container(),
                                    ),
                                    ListItemTemplate(
                                      title: "BDS",
                                      trailing: const HeroIcon(
                                        HeroIcons.check,
                                        color: ColorConstants.tertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
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
            const ListItem(
              title: "Lien ical",
              subtitle: "Synchroniser avec votre calendrier",
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
    );
  }
}

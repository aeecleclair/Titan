import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/tools/constants.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/centralisation/providers/centralisation_page_provider.dart';
import 'package:myecl/centralisation/providers/openLink.dart';
import 'package:myecl/centralisation/ui/pages/Main.dart';
import 'package:flutter_svg/flutter_svg.dart';


class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(centralisationPageProvider);
    final pageNotifier = ref.watch(centralisationPageProvider.notifier);
    final favorites = ref.watch(favoritesProvider);

    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                    onPressed: () {
                      switch (page) {
                      // Ajouter les actions correspondantes à vos besoins
                      }
                    },
                    icon: HeroIcon(
                      page == CentralisationPage.main
                          ? HeroIcons.bars3BottomLeft
                          : HeroIcons.chevronLeft,
                      color: Colors.black,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
            const Text(
              CentralisationTextConstants.centralisation,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: favorites.map((module) {
                return InkWell(
                  onTap: () {
                    openLink(module.url);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: module.icon.toLowerCase().endsWith('.svg')
                        ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(4.0),
                        child: SvgPicture.network(
                          "https://centralisation.eclair.ec-lyon.fr/assets/icons/" +
                              module.icon,
                        ),
                        width: 30,
                        height: 30,
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(4.0),
                        child: Image.network(
                          "https://centralisation.eclair.ec-lyon.fr/assets/icons/" +
                              module.icon,
                        ),
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        if (favorites.isNotEmpty && page == CentralisationPage.main)
          SizedBox(height: 5),
        if (page == CentralisationPage.main && favorites.isNotEmpty)
          Container(
            color: Colors.grey.shade300,
            height: 3,
            width: double.infinity,
          ),
        if (page == CentralisationPage.main && favorites.isEmpty)
          SizedBox(height: 25),
      ],
    );
  }
}



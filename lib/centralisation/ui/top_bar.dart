import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/tools/constants.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/centralisation/providers/centralisation_page_provider.dart';
import 'package:myecl/centralisation/tools/functions.dart';
import 'package:myecl/centralisation/providers/FavoritesNotifier.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(centralisationPageProvider);
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
                        case CentralisationPage.main:
                          controllerNotifier.toggle();
                          break;
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
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(25)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: const Offset(2, 3),
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(4.0),
                                child: module.icon.toLowerCase().endsWith('.svg')
                                    ? SvgPicture.network(
                                  "https://centralisation.eclair.ec-lyon.fr/assets/icons/" +
                                      module.icon,
                                  width: 30,
                                  height: 30,
                                )
                                    : Image.network(
                                  "https://centralisation.eclair.ec-lyon.fr/assets/icons/" +
                                      module.icon,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center ,
                                width: 60,
                                height: 30,
                                padding: EdgeInsets.only(bottom: 7),
                                child:
                                  AutoSizeText(
                                    module.name,
                                    style: TextStyle(fontSize: 16),
                                    minFontSize: 10,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),

                              ),
                            ],
                          ),
                        ),
                      ],
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
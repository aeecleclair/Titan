import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/centralisation/providers/FavoritesNotifier.dart';
import 'package:myecl/centralisation/tools/functions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionList extends HookConsumerWidget {
  final Section section;
  const SectionList({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    final favoritesProviderNotifier = ref.read(favoritesProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.name,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: section.moduleList
                .map<Widget>(
                  (e) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(2, 3),
                          ),
                        ]),
                    height: 70,
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
                        overlayColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(37, 0, 0, 0)),
                      ),
                      onLongPress: () {
                        showLinkDetails(context, e);
                      },
                      child: Row(
                        children: [
                          e.icon.endsWith('.svg')
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0, bottom: 3),
                                  width: 45,
                                  height: 45,
                                  child: SvgPicture.network(
                                    "https://centralisation.eclair.ec-lyon.fr/assets/icons/${e.icon}",
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0, bottom: 3),
                                  width: 45,
                                  height: 45,
                                  child: Image.network(
                                    "https://centralisation.eclair.ec-lyon.fr/assets/icons/${e.icon}",
                                  ),
                                ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  e.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: favorites.contains(e)
                                ? const Icon(Icons.star, color: Colors.grey)
                                : const Icon(Icons.star_border,
                                    color: Colors.grey),
                            onPressed: () {
                              favoritesProviderNotifier.toggleFavorite(e);
                            },
                          ),
                        ],
                      ),
                      onPressed: () {
                        openLink(e.url);
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

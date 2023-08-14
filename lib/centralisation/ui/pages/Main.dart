import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:myecl/centralisation/providers/centralisation_section_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myecl/centralisation/providers/openLink.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myecl/centralisation/providers/favoritesUtils.dart';
import 'dart:convert';
import 'dart:async';

class FavoritesNotifier extends StateNotifier<List<Module>> {
  FavoritesNotifier() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString('favorites');

    if (favoritesJson != null) {
      final favoritesList = json.decode(favoritesJson) as List<dynamic>;
      final favorites = favoritesList
          .map((moduleJson) => Module.fromJson(moduleJson))
          .toList();
      state = favorites;
    }
  }

  void toggleFavorite(Module module) {
    if (state.contains(module)) {
      state = state.where((m) => m != module).toList();
    } else {
      state = [...state, module];
    }
    saveFavoritesToSharedPreferences(
        state);
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Module>>(
        (ref) => FavoritesNotifier());

class LinksScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final favorites = ref.watch(favoritesProvider);

    void showLinkDetails(BuildContext context, Module module) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(utf8.decode(module.name.codeUnits)),
            content: Text(utf8.decode(module.description.codeUnits)),
            actions: [
              TextButton(
                child: const Text('Accéder au site'),
                onPressed: () {
                  openLink(module.url);
                },
              ),
              TextButton(
                child: const Text('Fermer'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void toggleFavorite(Module module) {
      final favoritesProviderNotifier = ref.read(favoritesProvider.notifier);
      favoritesProviderNotifier.toggleFavorite(module);
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 35.0,
          runSpacing: 40.0,
          children: section.when(
            data: (sections) => sections.map<Widget>((section) {
              final moduleWidgets = section.moduleList
                  .map<Widget>(
                    (e) => Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        width: MediaQuery.of(context).size.width / 1 -
                            0.05 * MediaQuery.of(context).size.width,
                        height: 70,
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(37, 0, 0, 0)),
                          ),
                          onLongPress: () {
                            showLinkDetails(context, e);
                          },
                          child: Row(
                            children: [
                              e.icon.toLowerCase().endsWith('.svg')
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
                              const SizedBox(
                                  width:
                                      10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      utf8.decode(e.name.codeUnits),
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
                                  toggleFavorite(e);
                                },
                              ),
                            ],
                          ),
                          onPressed: () {
                            openLink(e.url);
                          },
                        ),
                      ),
                    ),
                  )
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      utf8.decode(section.name.codeUnits),
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: moduleWidgets,
                  ),
                ],
              );
            }).toList(),
            loading: () => [],
            error: (err, stack) => [],
          ),
        ),
      ),
    );
  }
}

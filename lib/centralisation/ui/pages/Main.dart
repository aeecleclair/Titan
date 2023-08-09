import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/centralisation/repositories/section_repository.dart';
import 'package:myecl/centralisation/providers/centralisation_section_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myecl/centralisation/providers/openLink.dart';
import 'package:myecl/centralisation/providers/showLinkDetails.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
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
      final favorites = favoritesList.map((moduleJson) => Module.fromJson(moduleJson)).toList();
      state = favorites;
    }
  }


  void toggleFavorite(Module module) {
    if (state.contains(module)) {
      state = state.where((m) => m != module).toList();
    } else {
      state = [...state, module];
    }
    saveFavoritesToSharedPreferences(state); // Sauvegarder les favoris après modification
  }
}

final favoritesProvider =
StateNotifierProvider<FavoritesNotifier, List<Module>>(
        (ref) => FavoritesNotifier());

var _longPressProgress = 0.0;

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
                child: Text('Accéder au site'),
                onPressed: () {
                  openLink(module.url);
                },
              ),
              TextButton(
                child: Text('Fermer'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _handleLongPressStart(BuildContext context, Module module) {
      const updateInterval = Duration(milliseconds: 100);
      Timer.periodic(updateInterval, (timer) {
        if (_longPressProgress >= 0.5) {
          timer.cancel();
          showLinkDetails(context, module);
        } else {
          _longPressProgress += 0.1;
        }
      });
    }

    void _handleLongPressEnd() {
      _longPressProgress = 0.0;
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
            data: (sections) => sections
                .map<Widget>((section) {
              final moduleWidgets = section.moduleList.map<Widget>(
                    (e) => GestureDetector(
                  onLongPressStart: (_) {
                    _handleLongPressStart(context, e);
                  },
                  onLongPressEnd: (_) {
                    _handleLongPressEnd();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        width: MediaQuery.of(context).size.width / 1  - 0.05 * MediaQuery.of(context).size.width,
                        height: 70,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                            children: [
                              e.icon.toLowerCase().endsWith('.svg')
                                  ? Container(
                                margin: EdgeInsets.only(left: 10.0,right: 10.0, bottom : 3),
                                child: SvgPicture.network(
                                  "https://centralisation.eclair.ec-lyon.fr/assets/icons/" + e.icon,
                                ),
                                width: 45,
                                height: 45,
                              )
                                  : Container(
                                margin: EdgeInsets.only(left: 10.0,right: 10.0, bottom : 3),
                                child: Image.network(
                                  "https://centralisation.eclair.ec-lyon.fr/assets/icons/" + e.icon,
                                ),
                                width: 45,
                                height: 45,
                              ),
                              SizedBox(width: 10), // Ajoute un espace entre le logo et le texte
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      utf8.decode(e.name.codeUnits),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: favorites.contains(e)
                                    ? Icon(Icons.star)
                                    : Icon(Icons.star_border),
                                onPressed: () {
                                  toggleFavorite(e);
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            openLink(e.url);
                          },
                        ),
                      ),
                  ),
                ),
              ).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      utf8.decode(section.name.codeUnits),
                      style: TextStyle(
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
            })
                .toList(),
            loading: () => [],
            error: (err, stack) => [],
          ),
        ),
      ),
    );


  }
}







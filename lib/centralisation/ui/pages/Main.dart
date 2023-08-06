import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/centralisation/repositories/section_repository.dart';
import 'package:myecl/centralisation/providers/centralisation_section_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:myecl/centralisation/providers/openLink.dart';
import 'package:myecl/centralisation/providers/showLinkDetails.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:myecl/centralisation/providers/favoritesUtils.dart';
import 'dart:convert';
import 'dart:async';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Module>>(
        (ref) => FavoritesNotifier());



final SectionNotifier sectionNotifier = SectionNotifier();
var _longPressProgress = 0.0;

class LinksScreen extends HookConsumerWidget {
  @override



  Widget build(BuildContext context, WidgetRef ref) {
    final sectionNotifier = ref.watch(sectionProvider.notifier);
    final section = ref.watch(sectionProvider);
    final favorites = ref.watch(favoritesProvider);

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

    void toggleFavorite(Module module) {
      final favoritesProviderNotifier = ref.read(favoritesProvider.notifier);

      if (favorites.contains(module)) {
        favoritesProviderNotifier.toggleFavorite(module);
      } else {
        favoritesProviderNotifier.toggleFavorite(module);
      }

      // Save updated favorites list to SharedPreferences
      saveFavoritesToSharedPreferences(favorites);
    }



    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 8.0,
          runSpacing: 8.0,
          children: section.when(
            data: (sections) => sections
                .map<Widget>((section) {
              final moduleWidgets = section.moduleList.map<Widget>(
                    (e) => GestureDetector(
                      onLongPressStart: (_) {
                        _handleLongPressStart(context, e);
                      },
                      onLongPressEnd: (_) {
                        _longPressProgress = 0.0;
                      },
                      child: Opacity(
                        opacity: 1.0 - _longPressProgress,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1  - 0.03 * MediaQuery.of(context).size.width,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: e.icon.toLowerCase().endsWith('.svg')
                                ? Container(
                              width: 50,
                              height: 50,
                              child: SvgPicture.network(
                                "https://centralisation.eclair.ec-lyon.fr/assets/icons/" + e.icon,
                                fit: BoxFit.contain,
                              ),
                            )
                                : Image.network(
                              "https://centralisation.eclair.ec-lyon.fr/assets/icons/" + e.icon,
                              width: 50,
                              height: 50,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(e.name),
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
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      section.name, // Titre de la section
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...moduleWidgets,
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



class FavoritesNotifier extends StateNotifier<List<Module>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Module module) {
    if (state.contains(module)) {
      state = state.where((m) => m != module).toList();
    } else {
      state = [...state, module];
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/centralisation/repositories/section_repository.dart';
import 'package:myecl/centralisation/providers/centralisation_section_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Module>>(
        (ref) => FavoritesNotifier());



final SectionNotifier sectionNotifier = SectionNotifier();

class LinksScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionNotifier = ref.watch(sectionProvider.notifier);
    final section = ref.watch(sectionProvider);
    final favorites = ref.watch(favoritesProvider);

    print(favorites);



    void toggleFavorite(Module module) {
      if (favorites.contains(module)) {
        ref.read(favoritesProvider.notifier).toggleFavorite(module);
      } else {
        ref.read(favoritesProvider.notifier).toggleFavorite(module);
      }
    }

    void _openLink(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Impossible d\'ouvrir le lien $url';
      }
    }

    void _showLinkDetails(BuildContext context, Module module) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(module.name),
            content: Text(module.description),
            actions: [
              TextButton(
                child: Text('Accéder au site'),
                onPressed: () {
                  _openLink(module.url);
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


    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 8.0,
          runSpacing: 8.0,
          children: section.when(
            data: (sections) => sections
                .map<List<Widget>>(
                  (section) => section.moduleList.map<Widget>(
                    (e) => Container(
                  width: MediaQuery.of(context).size.width / 2 - 12.0, // Largeur des ListTiles
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,


                    leading: e.icon.toLowerCase().endsWith('.svg')
                        ? SvgPicture.network(
                      "https://centralisation.eclair.ec-lyon.fr/assets/icons/" + e.icon,
                    )
                        : Image.network(
                      "https://centralisation.eclair.ec-lyon.fr/assets/icons/" + e.icon,
                    ),

                    title: Row(
                      children: [
                        SizedBox(width: 8.0), // Espacement entre l'icône et le titre
                        Text(e.name),
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
                      _openLink(e.url);
                    },
                    onLongPress: () {
                      _showLinkDetails(context, e);
                    },
                  ),
                ),
              ).toList(),
            )
                .expand((element) => element)
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

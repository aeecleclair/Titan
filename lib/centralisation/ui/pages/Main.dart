import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myecl/centralisation//class/module.dart';
import 'package:myecl/centralisation//repositories/section_repository.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Centralisation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LinksScreen(),
    );
  }
}

final favoritesProvider =
StateNotifierProvider<FavoritesNotifier, List<Module>>((ref) => FavoritesNotifier());

class LinksScreen extends HookConsumerWidget {
  SectionRepository sectionRepository = SectionRepository();
  List<Section> sections = await sectionRepository.getSectionList();
  List<Module> modules = [];
  @override

  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final modules = useMemoized(
          () => [
        Module(
          icon: 'images/icon.png',
          name: 'Google',
          description: 'Recherche et plus',
          url: 'https://www.google.com',
          liked: false,
        ),
        Module(
          icon: 'images/icon.png',
          name: 'GitHub',
          description: 'Plateforme de développement collaboratif',
          url: 'https://www.github.com',
          liked: true,
        ),
        Module(
          icon: 'images/icon.png',
          name: 'Gmail',
          description: 'Service de messagerie de Google',
          url: 'https://mail.google.com',
          liked: false,
        ),
        // Ajoutez ici d'autres liens
      ],
      [],
    );

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Centralisation"),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final module = favorites[index];
              return IconButton(
                icon: Image.asset(module.icon),
                onPressed: () {
                  _openLink(module.url);
                },
              );
            },
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          final isFavorite = favorites.contains(module);

          return ListTile(
            leading: Image.asset(module.icon),
            title: Text(module.name),
            trailing: IconButton(
              icon: isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
              onPressed: () {
                toggleFavorite(module);
              },
            ),
            onTap: () {
              _openLink(module.url);
            },
            onLongPress: () {
              _showLinkDetails(context, module);
            },
          );
        },
      ),
      persistentFooterButtons: favorites.map((module) {
        return IconButton(
          icon: Image.asset(module.icon),
          onPressed: () {
            _openLink(module.url);
          },
        );
      }).toList(),
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.red,
        child: Center(
          child: Text(
            'Imaginé et conçu par ÉCLAIR',
            style: TextStyle(color: Colors.white),
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

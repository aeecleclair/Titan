import 'package:myecl/centralisation/class/module.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';



void showLinkDetails(BuildContext context, Module module) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(module.name),
        content: Text(module.description),
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



void openLink(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Impossible d\'ouvrir le lien $url';
  }
}

Future<void> saveFavoritesToSharedPreferences(List<Module> favoritesList) async {
  final prefs = await SharedPreferences.getInstance();
  final favoritesJson = favoritesList.map((module) => module.toJson()).toList();
  await prefs.setString('favorites', json.encode(favoritesJson));
}
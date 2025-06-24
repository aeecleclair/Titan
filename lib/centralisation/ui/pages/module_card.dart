import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/centralisation/class/module.dart';
import 'package:titan/centralisation/providers/favorites_providers.dart';
import 'package:titan/centralisation/tools/constants.dart';
import 'package:titan/centralisation/tools/functions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ModuleCard extends HookConsumerWidget {
  final Module module;
  const ModuleCard({super.key, required this.module});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesNameProvider);
    final favoritesProviderNotifier = ref.read(favoritesNameProvider.notifier);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      height: 70,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
          overlayColor: WidgetStateProperty.all<Color>(
            const Color.fromARGB(37, 0, 0, 0),
          ),
        ),
        onLongPress: () {
          showLinkDetails(context, module);
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 3),
              width: 45,
              height: 45,
              child: module.icon.endsWith('.svg')
                  ? SvgPicture.network(
                      "${CentralisationTextConstants.imagePath}${module.icon}",
                    )
                  : Image.network(
                      "${CentralisationTextConstants.imagePath}${module.icon}",
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    module.name,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: favorites.contains(module.name)
                  ? const Icon(Icons.star, color: Colors.grey)
                  : const Icon(Icons.star_border, color: Colors.grey),
              onPressed: () {
                favoritesProviderNotifier.toggleFavorite(module.name);
              },
            ),
          ],
        ),
        onPressed: () {
          openLink(module.url);
        },
      ),
    );
  }
}

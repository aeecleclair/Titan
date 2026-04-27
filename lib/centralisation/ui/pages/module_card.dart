import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/centralisation/class/module.dart';
import 'package:titan/centralisation/providers/favorites_providers.dart';
import 'package:titan/centralisation/tools/constants.dart';
import 'package:titan/centralisation/tools/functions.dart';

class ModuleCard extends HookConsumerWidget {
  final Module module;
  const ModuleCard({super.key, required this.module});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesNameProvider);
    final favoritesProviderNotifier = ref.read(favoritesNameProvider.notifier);
    final isFavorite = favorites.contains(module.name);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.25),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => openLink(module.url),
          onLongPress: () => showLinkDetails(context, module),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: module.icon.endsWith('.svg')
                              ? SvgPicture.network(
                                  "${CentralisationTextConstants.imagePath}${module.icon}",
                                  fit: BoxFit.contain,
                                )
                              : Image.network(
                                  "${CentralisationTextConstants.imagePath}${module.icon}",
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 30,
                      child: Center(
                        child: AutoSizeText(
                          module.name,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          minFontSize: 9,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () =>
                      favoritesProviderNotifier.toggleFavorite(module.name),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.amber : Colors.grey,
                      size: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

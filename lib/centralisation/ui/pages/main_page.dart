import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/providers/centralisation_section_provider.dart';
import 'package:myecl/centralisation/providers/favorites_providers.dart';
import 'package:myecl/centralisation/tools/constants.dart';
import 'package:myecl/centralisation/ui/centralisation.dart';

import 'package:myecl/centralisation/ui/pages/liked_card.dart';
import 'package:myecl/centralisation/ui/pages/section_list.dart';

class CentralisationMainPage extends HookConsumerWidget {
  const CentralisationMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final sections = ref.watch(sectionProvider);
    final favoritesName = ref.watch(favoritesNameProvider);
    final favoritesNameNotifier = ref.read(favoritesNameProvider.notifier);
    final favorites = sections.maybeWhen(
      data: (sections) {
        final modules = sections
            .map((section) => section.moduleList)
            .expand((element) => element);
        return favoritesName
            .map((name) => modules.firstWhere((module) => module.name == name))
            .toList();
      },
      orElse: () => [],
    );

    return CentralisationTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          if (favorites.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 5),
              height: 135,
              child: ReorderableListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                proxyDecorator: (widget, _, animation) => Transform.scale(
                  scale: 1 + .05 * animation.value,
                  child: widget,
                ),
                header: const SizedBox(
                  width: 15,
                ),
                footer: const SizedBox(
                  width: 15,
                ),
                onReorder: favoritesNameNotifier.reorderFavorites,
                children: favorites
                    .map((module) =>
                        LikedCard(module: module, key: Key(module.name)))
                    .toList(),
              ),
            ),
          ...section.when(
            data: (sections) => sections
                .map<Widget>((section) => SectionList(section: section))
                .toList(),
            loading: () => [
              const Center(
                child: CircularProgressIndicator(),
              )
            ],
            error: (err, stack) => [
              Center(
                child: Text('${CentralisationTextConstants.error} : $err'),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

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
    final favorites = ref.watch(favoritesProvider);

    return CentralisationTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 5),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  ...favorites.map((module) => LikedCard(module: module)),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
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

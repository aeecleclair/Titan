import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/tools/constants.dart';

class SectionTitle extends HookConsumerWidget {
  final List<SectionComplete> sectionList;
  const SectionTitle({super.key, required this.sectionList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    return AlignLeftText(
      section.id != EmptyModels.empty<SectionComplete>().id
          ? section.name
          : VoteTextConstants.noSection,
      padding: const EdgeInsets.only(left: 20),
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }
}

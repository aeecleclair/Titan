import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/vote/class/section.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/tools/constants.dart';

class SectionTitle extends HookConsumerWidget {
  final List<Section> sectionList;
  const SectionTitle({super.key, required this.sectionList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    return AlignLeftText(
      section.id != Section.empty().id
          ? section.name
          : VoteTextConstants.noSection,
      padding: const EdgeInsets.only(left: 20),
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }
}

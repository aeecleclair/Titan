import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/l10n/app_localizations.dart';

class SectionTitle extends HookConsumerWidget {
  final List<SectionComplete> sectionList;
  const SectionTitle({super.key, required this.sectionList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    return AlignLeftText(
      section.id != SectionComplete.empty().id
          ? section.name
          : AppLocalizations.of(context)!.voteNoSection,
      padding: const EdgeInsets.only(left: 20),
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/vote/providers/section_vote_count_provide.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/providers/sections_stats_provider.dart';

class VoteCount extends HookConsumerWidget {
  const VoteCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final sectionVoteNotifier = ref.watch(sectionVoteCountProvider.notifier);
    final stats = ref.watch(
      sectionsStatsProvider.select((value) => value[section]),
    );
    final statsNotifier = ref.read(sectionsStatsProvider.notifier);
    return AutoLoaderChild(
      group: stats,
      notifier: statsNotifier,
      mapKey: section,
      loader: (section) async => (await sectionVoteNotifier.loadCount(
        section.id,
      )).maybeWhen(data: (data) => data, orElse: () => -1),
      dataBuilder: (context, data) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Center(
            child: Text(
              '$data votes',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/loader.dart';
import 'package:myecl/vote/providers/section_vote_count_provide.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/sections_stats_provider.dart';

class VoteCount extends HookConsumerWidget {
  const VoteCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final sectionVoteNotifier = ref.watch(sectionVoteCountProvider.notifier);
    final stats = ref.watch(sectionsStatsProvider);
    final statsNotifier = ref.read(sectionsStatsProvider.notifier);
    return stats.when(
      data: (data) {
        final voteCount = data[section];
        if (voteCount == null) {
          Future.delayed(const Duration(milliseconds: 1),
              () => statsNotifier.setTData(section, const AsyncLoading()));
          tokenExpireWrapper(ref, () async {
            final count = await sectionVoteNotifier.loadCount(section.id);
            count.whenData(
              (data) => statsNotifier.setTData(section, AsyncData([data])),
            );
          });
          return const Center(
            child: Text('Error'),
          );
        }
        return voteCount.when(
          data: (data) {
            if (data.isEmpty) {
              Future.delayed(const Duration(milliseconds: 1),
                  () => statsNotifier.setTData(section, const AsyncLoading()));
              tokenExpireWrapper(ref, () async {
                final count = await sectionVoteNotifier.loadCount(section.id);
                count.whenData(
                  (data) => statsNotifier.setTData(section, AsyncData([data])),
                );
              });
              return const Center(
                child: Text('No votes'),
              );
            }
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
              child: Center(
                  child: Text(
                '${data[0]} votes',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              )),
            );
          },
          loading: () => const Loader(),
          error: (error, stack) => Center(
            child: Text('Error $error'),
          ),
        );
      },
      loading: () => const Loader(),
      error: (error, stack) => Center(
        child: Text('Error $error'),
      ),
    );
  }
}

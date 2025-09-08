import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/vote/repositories/section_vote_count_repository.dart';

class SectionVoteCountNotifier extends SingleNotifier<int> {
  final SectionVoteCountRepository repository;
  SectionVoteCountNotifier({required this.repository})
    : super(const AsyncLoading());

  Future<AsyncValue<int>> loadCount(String id) async {
    return await load(() => repository.getSectionVoteCount(id));
  }
}

final sectionVoteCountProvider =
    StateNotifierProvider<SectionVoteCountNotifier, AsyncValue<int>>((ref) {
      final repository = ref.watch(sectionVoteCountRepositoryProvider);
      return SectionVoteCountNotifier(repository: repository);
    });

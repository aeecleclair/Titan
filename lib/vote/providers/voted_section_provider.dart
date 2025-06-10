import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/vote/repositories/voted_sections_repository.dart';

class VotedSectionProvider extends ListNotifier<String> {
  final VotedSectionRepository votesRepository;
  VotedSectionProvider({required this.votesRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<String>>> getVotedSections() async {
    return await loadList(votesRepository.getVotes);
  }

  void addVote(String id) {
    state.maybeWhen(
      data: (value) {
        state = AsyncData(value..add(id));
      },
      orElse: () {},
    );
  }
}

final votedSectionProvider =
    StateNotifierProvider<VotedSectionProvider, AsyncValue<List<String>>>((
      ref,
    ) {
      final votesRepository = ref.watch(votedSectionRepositoryProvider);
      VotedSectionProvider votesProvider = VotedSectionProvider(
        votesRepository: votesRepository,
      );
      return votesProvider;
    });

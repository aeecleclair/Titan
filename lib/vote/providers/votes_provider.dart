import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/vote/class/votes.dart';
import 'package:titan/vote/repositories/votes_repository.dart';

class VotesProvider extends ListNotifier<Votes> {
  final VotesRepository votesRepository;
  VotesProvider({required this.votesRepository})
    : super(const AsyncValue.loading());

  Future<bool> addVote(Votes votes) async {
    try {
      await votesRepository.addVote(votes);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeVote() async {
    return await delete(
      (_) => votesRepository.removeVote(),
      (listVotes, votes) => [],
      "",
      Votes.empty(),
    );
  }

  Future<AsyncValue<List<Votes>>> copy() async {
    return state.whenData((listVotes) => listVotes);
  }
}

final votesProvider =
    StateNotifierProvider<VotesProvider, AsyncValue<List<Votes>>>((ref) {
      final votesRepository = ref.watch(votesRepositoryProvider);
      VotesProvider votesProvider = VotesProvider(
        votesRepository: votesRepository,
      );
      return votesProvider;
    });

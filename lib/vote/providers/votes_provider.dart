import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/vote/class/votes.dart';
import 'package:myecl/vote/repositories/votes_repository.dart';

class VotesProvider extends ListNotifier<Votes> {
  final votesRepository = VotesRepository();
  VotesProvider({required String token}) : super(const AsyncValue.loading()) {
    votesRepository.setToken(token);
  }

  Future<AsyncValue<List<Votes>>> getVotes() async {
    return await loadList(votesRepository.getVotes);
  }

  Future<AsyncValue<List<Votes>>> getVoteById(String id) async {
    return await loadList(() async => votesRepository.getVote(id));
  }

  Future<bool> addVote(Votes votes) async {
    return await add(votesRepository.addVote, votes);
  }

  Future<bool> removeVote() async {
    return await delete((_) => votesRepository.removeVote(),
        (listVotes, votes) => [], "", Votes.empty());
  }

  Future<AsyncValue<List<Votes>>> copy() async {
    return state.when(
      data: (listVotes) => AsyncValue.data(listVotes),
      loading: () => const AsyncValue.loading(),
      error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    );
  }
}

final votesProvider =
    StateNotifierProvider<VotesProvider, AsyncValue<List<Votes>>>((ref) {
  final token = ref.watch(tokenProvider);
  return VotesProvider(token: token);
});

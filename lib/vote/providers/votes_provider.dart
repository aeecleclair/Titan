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

  Future<bool> addVote(Votes votes) async {
    try {
      await votesRepository.addVote(votes);
      return true;
    } catch (e) {
      rethrow;
    }
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
  VotesProvider votesProvider = VotesProvider(token: token);
  return votesProvider;
});

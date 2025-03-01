import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/repository/repository2.dart';

class VotesProvider extends ListNotifier<void> {
  final Openapi votesRepository;
  VotesProvider({required this.votesRepository})
      : super(const AsyncValue.loading());

  Future<bool> addVote(VoteBase votes) async {
    try {
      await votesRepository.campaignVotesPost(body: votes);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<AsyncValue<List<void>>> copy() async {
    return state.whenData((listVotes) => listVotes);
  }
}

final votesProvider =
    StateNotifierProvider<VotesProvider, AsyncValue<List<void>>>((ref) {
  final votesRepository = ref.watch(repositoryProvider);
  VotesProvider votesProvider = VotesProvider(votesRepository: votesRepository);
  return votesProvider;
});

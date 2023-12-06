import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/repository/repository2.dart';

class VotesProvider extends ListNotifier<String> {
  final Openapi votesRepository;
  VotesProvider({required this.votesRepository})
      : super(const AsyncValue.loading());

  Future<bool> addVote(String listId) async {
    try {
      await votesRepository.campaignVotesPost(body: VoteBase(
        listId: listId,
      ));
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<AsyncValue<List<String>>> copy() async {
    return state.whenData((listVotes) => listVotes);
  }
}

final votesProvider =
    StateNotifierProvider<VotesProvider, AsyncValue<List<String>>>((ref) {
  final votesRepository = ref.watch(repositoryProvider);
  VotesProvider votesProvider = VotesProvider(votesRepository: votesRepository);
  return votesProvider;
});

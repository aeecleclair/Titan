import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class VotesProvider extends ListNotifier<VoteBase> {
  Openapi get votesRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<VoteBase>> build() {
    return const AsyncValue.loading();
  }

  Future<bool> addVote(VoteBase votes) async {
    try {
      await votesRepository.campaignVotesPost(body: votes);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<AsyncValue<List<VoteBase>>> copy() async {
    return state.whenData((listVotes) => listVotes);
  }
}

final votesProvider =
    NotifierProvider<VotesProvider, AsyncValue<List<VoteBase>>>(
      VotesProvider.new,
    );

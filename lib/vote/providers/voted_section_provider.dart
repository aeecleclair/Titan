import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/vote/repositories/voted_sections_repository.dart';

class VotedSectionProvider extends ListNotifier<String> {
  final votesRepository = VotedSectionRepository();
  VotedSectionProvider({required String token})
      : super(const AsyncValue.loading()) {
    votesRepository.setToken(token);
  }

  Future<AsyncValue<List<String>>> getVotedSections() async {
    return await loadList(votesRepository.getVotes);
  }

  void addVote(String id) {
    state.maybeWhen(
        data: (value) {
          state = AsyncData(value..add(id));
        },
        orElse: () {});
  }
}

final votedSectionProvider =
    StateNotifierProvider<VotedSectionProvider, AsyncValue<List<String>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  VotedSectionProvider votesProvider = VotedSectionProvider(token: token);
  return votesProvider;
});

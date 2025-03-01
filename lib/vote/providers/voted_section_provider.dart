import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';

class VotedSectionProvider extends ListNotifier2<String> {
  final Openapi votesRepository;
  VotedSectionProvider({required this.votesRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<String>>> getVotedSections() async {
    return await loadList(votesRepository.campaignVotesGet);
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
    StateNotifierProvider<VotedSectionProvider, AsyncValue<List<String>>>(
        (ref) {
  final votesRepository = ref.watch(repositoryProvider);
  VotedSectionProvider votesProvider = VotedSectionProvider(
    votesRepository: votesRepository,
  );
  return votesProvider;
});

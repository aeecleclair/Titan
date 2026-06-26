import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class VotedSectionProvider extends ListNotifierAPI<String> {
  Openapi get votesRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<String>> build() {
    return const AsyncValue.loading();
  }

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
    NotifierProvider<VotedSectionProvider, AsyncValue<List<String>>>(
      VotedSectionProvider.new,
    );

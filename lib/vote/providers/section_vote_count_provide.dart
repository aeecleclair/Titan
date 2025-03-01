import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';

class SectionVoteCountNotifier extends SingleNotifier2<VoteStats> {
  final Openapi repository;
  SectionVoteCountNotifier({required this.repository})
      : super(const AsyncLoading());

  Future<AsyncValue<VoteStats>> loadCount(String sectionId) async {
    return await load(() => repository.campaignStatsSectionIdGet(sectionId: sectionId));
  }
}

final sectionVoteCountProvider =
    StateNotifierProvider<SectionVoteCountNotifier, AsyncValue<VoteStats>>((ref) {
  final repository = ref.watch(repositoryProvider);
  return SectionVoteCountNotifier(repository: repository);
});

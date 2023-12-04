import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';

class SectionVoteCountNotifier extends SingleNotifier2<VoteStats> {
  final Openapi sectionVoteCountRepository;
  SectionVoteCountNotifier({required this.sectionVoteCountRepository})
      : super(const AsyncLoading());

  Future<AsyncValue<VoteStats>> loadCount(String id) async {
    return await load(() =>
        sectionVoteCountRepository.campaignStatsSectionIdGet(sectionId: id));
  }
}

final sectionVoteCountProvider =
    StateNotifierProvider<SectionVoteCountNotifier, AsyncValue<VoteStats>>(
        (ref) {
  final sectionVoteCountRepository = ref.watch(repositoryProvider);
  return SectionVoteCountNotifier(
      sectionVoteCountRepository: sectionVoteCountRepository);
});

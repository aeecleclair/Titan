import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class SectionVoteCountNotifier extends SingleNotifierAPI<VoteStats> {
  final Openapi repository;
  SectionVoteCountNotifier({required this.repository})
      : super(const AsyncLoading());

  Future<AsyncValue<VoteStats>> loadCount(String sectionId) async {
    return await load(
      () => repository.campaignStatsSectionIdGet(sectionId: sectionId),
    );
  }
}

final sectionVoteCountProvider =
    StateNotifierProvider<SectionVoteCountNotifier, AsyncValue<VoteStats>>(
        (ref) {
  final repository = ref.watch(repositoryProvider);
  return SectionVoteCountNotifier(repository: repository);
});

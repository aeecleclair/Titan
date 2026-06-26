import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class SectionVoteCountNotifier extends SingleNotifierAPI<VoteStats> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<VoteStats> build() {
    return const AsyncLoading();
  }

  Future<AsyncValue<VoteStats>> loadCount(String sectionId) async {
    return await load(
      () => repository.campaignStatsSectionIdGet(sectionId: sectionId),
    );
  }
}

final sectionVoteCountProvider =
    NotifierProvider<SectionVoteCountNotifier, AsyncValue<VoteStats>>(
      SectionVoteCountNotifier.new,
    );

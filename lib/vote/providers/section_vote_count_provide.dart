import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/vote/repositories/section_vote_count_repository.dart';

class SectionVoteCountNotifier extends SingleNotifier<int> {
  final SectionVoteCountRepository _repository = SectionVoteCountRepository();
  SectionVoteCountNotifier(String token) : super(const AsyncLoading()) {
    _repository.setToken(token);
  }

  Future<AsyncValue<int>> loadCount(String id) async {
    return await load(() => _repository.getSectionVoteCount(id));
  }
}

final sectionVoteCountProvider =
    StateNotifierProvider<SectionVoteCountNotifier, AsyncValue<int>>((ref) {
  final token = ref.watch(tokenProvider);
  return SectionVoteCountNotifier(token);
});

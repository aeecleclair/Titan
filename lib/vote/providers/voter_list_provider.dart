import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/vote/class/voter.dart';
import 'package:titan/vote/repositories/voter_repository.dart';

class VoterListNotifier extends ListNotifier<Voter> {
  final VoterRepository _voterRepository = VoterRepository();
  VoterListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    _voterRepository.setToken(token);
  }

  Future<AsyncValue<List<Voter>>> loadVoterList() async {
    return await loadList(_voterRepository.getVoters);
  }

  Future<bool> addVoter(Voter voter) async {
    return await add(_voterRepository.createVoter, voter);
  }

  Future<bool> deleteVoter(Voter voter) async {
    return await delete(
      _voterRepository.deleteVoter,
      (voters, voter) => voters..removeWhere((p) => p.groupId == voter.groupId),
      voter.groupId,
      voter,
    );
  }
}

final voterListProvider =
    StateNotifierProvider<VoterListNotifier, AsyncValue<List<Voter>>>((ref) {
      final token = ref.watch(tokenProvider);
      final voterListNotifier = VoterListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await voterListNotifier.loadVoterList();
      });
      return voterListNotifier;
    });

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/voter.dart';
import 'package:myecl/vote/repositories/voter_repository.dart';

class VoterListNotifier extends ListNotifier<Voter> {
  final VoterRepository _voterRepository;
  VoterListNotifier(this._voterRepository) : super(const AsyncValue.loading());

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
      final repository = ref.watch(voterRepositoryProvider);
      final voterListNotifier = VoterListNotifier(repository);
      tokenExpireWrapperAuth(ref, () async {
        await voterListNotifier.loadVoterList();
      });
      return voterListNotifier;
    });

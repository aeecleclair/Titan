import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class VoterListNotifier extends ListNotifierAPI<VoterGroup> {
  final Openapi voterRepository;
  VoterListNotifier({required this.voterRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<VoterGroup>>> loadVoterList() async {
    return await loadList(voterRepository.campaignVotersGet);
  }

  Future<bool> addVoter(VoterGroup voter) async {
    return await add(
        () => voterRepository.campaignVotersPost(body: voter), voter);
  }

  Future<bool> deleteVoter(VoterGroup voter) async {
    return await delete(
      () => voterRepository.campaignVotersGroupIdDelete(groupId: voter.groupId),
      (voters) => voters..removeWhere((p) => p.groupId == voter.groupId),
    );
  }
}

final voterListProvider =
    StateNotifierProvider<VoterListNotifier, AsyncValue<List<VoterGroup>>>(
        (ref) {
  final voterRepository = ref.watch(repositoryProvider);
  final voterListNotifier = VoterListNotifier(voterRepository: voterRepository);
  tokenExpireWrapperAuth(ref, () async {
    await voterListNotifier.loadVoterList();
  });
  return voterListNotifier;
});

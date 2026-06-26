import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class VoterListNotifier extends SingleNotifierAPI<CorePermission> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<CorePermission> build() {
    loadVoterList();
    return const AsyncLoading();
  }

  Future<AsyncValue<CorePermission>> loadVoterList() async {
    return await load(repository.campaignVotersGet);
  }

  Future<bool> addVoter(String groupId) async {
    final response = await repository.campaignVotersGroupIdPost(
      groupId: groupId,
    );
    if (response.isSuccessful) {
      await loadVoterList();
      return true;
    }
    return false;
  }

  Future<bool> deleteVoter(String groupId) async {
    final response = await repository.campaignVotersGroupIdDelete(
      groupId: groupId,
    );
    if (response.isSuccessful) {
      await loadVoterList();
      return true;
    }
    return false;
  }
}

final voterListProvider =
    NotifierProvider<VoterListNotifier, AsyncValue<CorePermission>>(
      VoterListNotifier.new,
    );

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/repositories/sharer_group_repository.dart';

class SharerGroupNotifier extends SingleNotifier<SharerGroup> {
  final SharerGroupRepository sharerGroupRepository = SharerGroupRepository();
  SharerGroupNotifier({required String token})
      : super(const AsyncValue.loading()) {
    sharerGroupRepository.setToken(token);
  }

  Future<AsyncValue<SharerGroup>> loadSharerGroup(String sharerGroupId) async {
    return await load(
        () => sharerGroupRepository.getSharerGroup(sharerGroupId));
  }

  Future<bool> addSharerGroup(SharerGroup sharerGroup) async {
    return await add(sharerGroupRepository.createSharerGroup, sharerGroup);
  }

  Future<bool> updateSharerGroup(SharerGroup sharerGroup) async {
    return await update(sharerGroupRepository.updateSharerGroup, sharerGroup);
  }
}

final sharerGroupProvider =
    StateNotifierProvider<SharerGroupNotifier, AsyncValue<SharerGroup>>((ref) {
  final token = ref.watch(tokenProvider);
  return SharerGroupNotifier(token: token);
});

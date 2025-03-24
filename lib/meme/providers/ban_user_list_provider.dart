import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/repositories/ban_user_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/class/list_users.dart';

class BanListNotifier extends ListNotifier<SimpleUser> {
  final BanRepository _banRepository = BanRepository();

  BanListNotifier({required String token}) : super(const AsyncLoading()) {
    _banRepository.setToken(token);
  }

  Future<AsyncValue<List<SimpleUser>>> getBannedUsers() async {
    return await loadList(() async => _banRepository.getBannedUsers());
  }

  Future<bool> banUser(String id) async {
    return await _banRepository.banUser(id);
  }

  Future<bool> unbanUser(String id) async {
    return await _banRepository.unbanUser(id);
  }
}

final bannedUsersProvider =
    StateNotifierProvider<BanListNotifier, AsyncValue<List<SimpleUser>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = BanListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getBannedUsers();
  });
  return notifier;
});

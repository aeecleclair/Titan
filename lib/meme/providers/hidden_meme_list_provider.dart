import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/meme/repositories/hidden_meme_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class HiddenMemeListNotifier extends ListNotifier<Meme> {
  final HiddenMemeRepository _hiddenMemeRepository = HiddenMemeRepository();

  HiddenMemeListNotifier({required String token})
      : super(const AsyncLoading()) {
    _hiddenMemeRepository.setToken(token);
  }

  Future<AsyncValue<List<Meme>>> getHiddenMeme(int page) async {
    return await loadList(
        () async => _hiddenMemeRepository.getBannedMeme(page));
  }

  Future<bool> hideMeme(String id) async {
    return await _hiddenMemeRepository.hideMeme(id);
  }

  Future<bool> showMeme(String id) async {
    return await _hiddenMemeRepository.showMeme(id);
  }
}

final hiddenMemeProvider =
    StateNotifierProvider<HiddenMemeListNotifier, AsyncValue<List<Meme>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final notifier = HiddenMemeListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getHiddenMeme(1);
  });
  return notifier;
});

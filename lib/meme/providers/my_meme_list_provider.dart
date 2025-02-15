import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/meme/repositories/my_meme_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MyMemeListNotifier extends ListNotifier<Meme> {
  final MyMemeRepository _myMemeRepository = MyMemeRepository();
  MyMemeListNotifier({required String token}) : super(const AsyncLoading()) {
    _myMemeRepository.setToken(token);
  }

  Future<AsyncValue<List<Meme>>> getMyMeme(int page) async {
    return await loadList(
      () async => _myMemeRepository.getMyMeme(page),
    );
  }

  Future<bool> addMeme(Uint8List bytes) async {
    final success = await _myMemeRepository.addMeme(bytes);
    return success;
  }
}

final myMemeListProvider =
    StateNotifierProvider<MyMemeListNotifier, AsyncValue<List<Meme>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = MyMemeListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getMyMeme(1);
  });
  return notifier;
});

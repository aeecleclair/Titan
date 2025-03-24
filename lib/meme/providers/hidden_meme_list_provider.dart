import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/meme/repositories/hidden_meme_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class HiddenMemeListNotifier extends ListNotifier<Meme> {
  final _hiddenMemeRepository = HiddenMemeRepository();
  HiddenMemeListNotifier({required String token})
      : super(const AsyncLoading()) {
    _hiddenMemeRepository.setToken(token);
  }

  Future<AsyncValue<List<Meme>>> getHiddenMeme() async {
    return await loadList(
      () async => _hiddenMemeRepository.getHiddenMeme(),
    );
  }

  Future<Uint8List> getMemeImage(String id) async {
    return await _hiddenMemeRepository.getMemeImage(id);
  }

  Future<bool> hideMeme(Meme meme) async {
    return await update(
      (meme) => _hiddenMemeRepository.hideMeme(meme.id),
      (memes, meme) => memes..[memes.indexWhere((p) => p.id == meme.id)] = meme,
      meme.copyWith(status: "hidden"),
    );
  }

  Future<bool> showMeme(Meme meme) async {
    return await update(
      (meme) => _hiddenMemeRepository.showMeme(meme.id),
      (memes, meme) => memes..[memes.indexWhere((p) => p.id == meme.id)] = meme,
      meme.copyWith(status: "neutral"),
    );
  }
}

final hiddenMemeListProvider =
    StateNotifierProvider<HiddenMemeListNotifier, AsyncValue<List<Meme>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final notifier = HiddenMemeListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getHiddenMeme();
  });
  return notifier;
});

import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/meme/repositories/my_meme_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MyMemeListNotifier extends ListNotifier<Meme> {
  final _myMemeRepository = MyMemeRepository();
  MyMemeListNotifier({required String token}) : super(const AsyncLoading()) {
    _myMemeRepository.setToken(token);
  }

  Future<AsyncValue<List<Meme>>> getMyMeme() async {
    return await loadList(() async => _myMemeRepository.getMyMeme());
  }

  Future<bool> addMeme(Uint8List bytes) async {
    final success = await _myMemeRepository.addMeme(bytes);
    return success;
  }

  Future<Uint8List> getMemeImage(String id) async {
    return await _myMemeRepository.getMemeImage(id);
  }

  Future<bool> deleteMeme(Meme meme) async {
    return await _myMemeRepository.deleteMeme(meme.id);
  }
}

final myMemeListProvider =
    StateNotifierProvider<MyMemeListNotifier, AsyncValue<List<Meme>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = MyMemeListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getMyMeme();
  });
  return notifier;
});

import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/sorting_bar_provider.dart';
import 'package:myecl/meme/repositories/meme_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class MemeListNotifier extends ListNotifier<Meme> {
  final MemeRepository _memeRepository = MemeRepository();
  MemeListNotifier({required String token}) : super(const AsyncLoading()) {
    _memeRepository.setToken(token);
  }

  Future<AsyncValue<List<Meme>>> getMeme(SortingType s) async {
    return await loadList(() async => _memeRepository.getMeme(s));
  }

  Future<Uint8List> getMemeImage(String id) async {
    return await _memeRepository.getMemeImage(id);
  }

  Future<bool> addVoteToMeme(Meme meme, bool positive) async {
    return await add(
      (meme) => _memeRepository.addVoteToMeme(meme, positive),
      meme,
    );
  }

  Future<bool> deleteVoteToMeme(Meme meme) async {
    return await update(
      (meme) => _memeRepository.deleteVoteToMeme(
        meme.id,
      ),
      (memes, meme) {
        final updatedMemes = memes.map((m) {
          if (m.id == meme.id) {
            m.myVote = null;
          }
          return m;
        }).toList();
        return updatedMemes;
      },
      meme,
    );
  }

  Future<bool> updateVoteToMeme(Meme meme, bool positive) async {
    return await update(
      (meme) => _memeRepository.updateVoteToMeme(meme, positive),
      (memes, meme) {
        final updatedMemes = memes.map((m) {
          if (m.id == meme.id) {
            m.myVote = positive;
          }
          return m;
        }).toList();
        return updatedMemes;
      },
      meme,
    );
  }

  Future<bool> deleteMeme(Meme meme) async {
    return await _memeRepository.deleteMeme(meme.id);
  }
}

final memeListProvider =
    StateNotifierProvider<MemeListNotifier, AsyncValue<List<Meme>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = MemeListNotifier(token: token);
  final s = ref.watch(selectedSortingTypeProvider);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getMeme(s);
  });
  return notifier;
});

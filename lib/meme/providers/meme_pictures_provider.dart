import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/meme/providers/meme_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MemePicturesNotifier extends MapNotifier<Meme, Image> {
  MemePicturesNotifier() : super();
}

final memePicturesProvider = StateNotifierProvider<MemePicturesNotifier,
    Map<Meme, AsyncValue<List<Image>>?>>((ref) {
  MemePicturesNotifier memePicturesNotifier = MemePicturesNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(memeListProvider).maybeWhen(
      data: (meme) {
        memePicturesNotifier.loadTList(meme);
        return MemePicturesNotifier;
      },
      orElse: () {
        memePicturesNotifier.loadTList([]);
        return memePicturesNotifier;
      },
    );
  });
  return memePicturesNotifier;
});

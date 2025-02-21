import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/providers/meme_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MemePicturesNotifier extends MapNotifier<String, Image> {
  MemePicturesNotifier() : super();
}

final memePicturesProvider = StateNotifierProvider<MemePicturesNotifier,
    Map<String, AsyncValue<List<Image>>?>>((ref) {
  MemePicturesNotifier memePicturesNotifier = MemePicturesNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(memeListProvider).maybeWhen(
      data: (value) {
        memePicturesNotifier.loadTList(value.map((e) => e.id).toList());
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

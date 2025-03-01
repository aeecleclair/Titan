import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/meme/providers/meme_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MemesNotifier extends MapNotifier<String, Meme> {
  MemesNotifier();
}

final memesProvider =
    StateNotifierProvider<MemesNotifier, Map<String, AsyncValue<List<Meme>>?>>(
        (ref) {
  MemesNotifier memesNotifier = MemesNotifier();
  tokenExpireWrapperAuth(ref, () async {
    final memes = ref.watch(memeListProvider);
    memes.whenData((value) {
      memesNotifier.loadTList(value.map((e) => e.id).toList());
    });
  });
  return memesNotifier;
});

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/rplace/class/pixel.dart';
import 'package:myecl/rplace/repositories/pixels_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PixelListNotifier extends ListNotifier<Pixel> {
  final PixelRepository _pixelRepository = PixelRepository();
  PixelListNotifier({required String token}) : super(const AsyncLoading()) {
    _pixelRepository.setToken(token);
  }

  Future<AsyncValue<List<Pixel>>> getPixels() async {
    return await loadList(_pixelRepository.getPixels);
  }

  Future<bool> createPixel(Pixel pixel) async {
    return await add(_pixelRepository.createPixel, pixel);
  }
}

final pixelListProvider =
    StateNotifierProvider<PixelListNotifier, AsyncValue<List<Pixel>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = PixelListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getPixels();
  });
  return notifier;
});

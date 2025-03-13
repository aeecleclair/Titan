import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/rplace/class/pixelinfo.dart';
import 'package:myecl/rplace/repositories/pixelinfo_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class pixelinfoNotifier extends SingleNotifier<PixelInfo> {
  final PixelInfoRepository _pixelinfoRepository = PixelInfoRepository();
  pixelinfoNotifier({required String token}) : super(const AsyncLoading()) {
    _pixelinfoRepository.setToken(token);
  }

  Future<AsyncValue<PixelInfo>> getPixelInfo(int x, int y) async {
    return await load(() async => _pixelinfoRepository.getPixelInfo(x, y));
  }
}

final pixelInfoProvider =
    StateNotifierProvider<pixelinfoNotifier, AsyncValue<PixelInfo>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = pixelinfoNotifier(token: token);
  return notifier;
});

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/rplace/class/pixelinfo.dart';
import 'package:titan/rplace/repositories/pixelinfo_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class PixelInfoNotifier extends SingleNotifier<PixelInfo> {
  final PixelInfoRepository _pixelinfoRepository = PixelInfoRepository();
  PixelInfoNotifier({required String token}) : super(const AsyncLoading()) {
    _pixelinfoRepository.setToken(token);
  }

  Future<AsyncValue<PixelInfo>> getPixelInfo(int x, int y) async {
    return await load(() async => _pixelinfoRepository.getPixelInfo(x, y));
  }
}

final pixelInfoProvider =
    StateNotifierProvider<PixelInfoNotifier, AsyncValue<PixelInfo>>((ref) {
      final token = ref.watch(tokenProvider);
      final notifier = PixelInfoNotifier(token: token);
      return notifier;
    });

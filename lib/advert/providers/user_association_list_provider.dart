import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/advert/class/advert.dart';
import 'package:titan/advert/repositories/advert_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class AdvertListNotifier extends ListNotifier<Advert> {
  AdvertRepository repository = AdvertRepository();
  AdvertListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Advert>>> loadUserAssmicationList() async {
    return await loadList(repository.getAllAdvert);
  }
}

final advertListProvider =
    StateNotifierProvider<AdvertListNotifier, AsyncValue<List<Advert>>>((ref) {
      final token = ref.watch(tokenProvider);
      AdvertListNotifier notifier = AdvertListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadUserAssmicationList();
      });
      return notifier;
    });

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

  Future<AsyncValue<List<Advert>>> loadAdverts() async {
    return await loadList(repository.getAllAdvert);
  }

  Future<bool> addAdvert(Advert advert) async {
    return await add(repository.addAdvert, advert);
  }

  Future<bool> updateAdvert(Advert advert) async {
    return await update(
      repository.updateAdvert,
      (adverts, advert) =>
          adverts..[adverts.indexWhere((b) => b.id == advert.id)] = advert,
      advert,
    );
  }

  Future<bool> deleteAdvert(Advert advert) async {
    return await delete(
      repository.deleteAdvert,
      (adverts, advert) => adverts..removeWhere((b) => b.id == advert.id),
      advert.id,
      advert,
    );
  }
}

final advertListProvider =
    StateNotifierProvider<AdvertListNotifier, AsyncValue<List<Advert>>>((ref) {
      final token = ref.watch(tokenProvider);
      AdvertListNotifier notifier = AdvertListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadAdverts();
      });
      return notifier;
    });

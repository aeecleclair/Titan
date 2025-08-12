import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/advert/class/advert.dart';
import 'package:titan/advert/repositories/advert_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class AdminAdvertListNotifier extends ListNotifier<Advert> {
  AdvertRepository repository = AdvertRepository();
  AdminAdvertListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Advert>>> loadAdverts() async {
    return await loadList(repository.getAllAdminAdvert);
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

final adminAdvertListProvider =
    StateNotifierProvider<AdminAdvertListNotifier, AsyncValue<List<Advert>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      AdminAdvertListNotifier notifier = AdminAdvertListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadAdverts();
      });
      return notifier;
    });

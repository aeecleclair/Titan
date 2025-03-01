import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/advert/adapters/advert.dart';

class AdvertListNotifier extends ListNotifierAPI<AdvertReturnComplete> {
  final Openapi advertListRepository;
  AdvertListNotifier({required this.advertListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AdvertReturnComplete>>> loadAdverts() async {
    return await loadList(advertListRepository.advertAdvertsGet);
  }

  Future<bool> addAdvert(AdvertBase advert) async {
    return await add(
      () => advertListRepository.advertAdvertsPost(body: advert),
      advert,
    );
  }

  Future<bool> updateAdvert(AdvertReturnComplete advert) async {
    return await update(
      () => advertListRepository.advertAdvertsAdvertIdPatch(
        advertId: advert.id,
        body: advert.toAdvertUpdate(),
      ),
      (advert) => advert.id,
      advert,
    );
  }

  Future<bool> deleteAdvert(AdvertReturnComplete advert) async {
    return await delete(
      () =>
          advertListRepository.advertAdvertsAdvertIdDelete(advertId: advert.id),
      (adverts) => adverts..removeWhere((b) => b.id == advert.id),
    );
  }
}

final advertListProvider = StateNotifierProvider<AdvertListNotifier,
    AsyncValue<List<AdvertReturnComplete>>>((ref) {
  final advertListRepository = ref.watch(repositoryProvider);
  AdvertListNotifier notifier =
      AdvertListNotifier(advertListRepository: advertListRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadAdverts();
  });
  return notifier;
});

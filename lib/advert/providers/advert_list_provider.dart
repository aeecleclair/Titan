import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AdvertListNotifier extends ListNotifier2<AdvertReturnComplete> {
  final Openapi advertListRepository;
  AdvertListNotifier({required this.advertListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AdvertReturnComplete>>> loadAdverts() async {
    return await loadList(advertListRepository.advertAdvertsGet);
  }

  Future<bool> addAdvert(AdvertReturnComplete advert) async {
    return await add(
        (advert) async => advertListRepository.advertAdvertsPost(
                body: AdvertBase(
              title: advert.title,
              content: advert.content,
              advertiserId: advert.advertiserId,
              tags: advert.tags,
            )),
        advert);
  }

  Future<bool> updateAdvert(AdvertReturnComplete advert) async {
    return await update(
        (advert) async => advertListRepository.advertAdvertsAdvertIdPatch(
            advertId: advert.id,
            body: AdvertUpdate(
              title: advert.title,
              content: advert.content,
              tags: advert.tags,
            )),
        (adverts, advert) =>
            adverts..[adverts.indexWhere((b) => b.id == advert.id)] = advert,
        advert);
  }

  Future<bool> deleteAdvert(AdvertReturnComplete advert) async {
    return await delete(
        (advertId) async => advertListRepository.advertAdvertsAdvertIdDelete(
            advertId: advertId),
        (adverts, advert) => adverts..removeWhere((b) => b.id == advert.id),
        advert.id,
        advert);
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

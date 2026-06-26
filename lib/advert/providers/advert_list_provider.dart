import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/advert/adapters/advert_complete.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class AdvertListNotifier extends ListNotifierAPI<AdvertComplete> {
  Openapi get advertListRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AdvertComplete>> build() {
    loadAdverts();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AdvertComplete>>> loadAdverts() async {
    return await loadList(advertListRepository.advertAdvertsGet);
  }

  Future<bool> addAdvert(AdvertBase advert) async {
    return await add(
      () => advertListRepository.advertAdvertsPost(body: advert),
      advert,
    );
  }

  Future<bool> updateAdvert(AdvertComplete advert) async {
    return await update(
      () => advertListRepository.advertAdvertsAdvertIdPatch(
        advertId: advert.id,
        body: advert.toAdvertUpdate(),
      ),
      (advert) => advert.id,
      advert,
    );
  }

  Future<bool> deleteAdvert(AdvertComplete advert) async {
    return await delete(
      () =>
          advertListRepository.advertAdvertsAdvertIdDelete(advertId: advert.id),
      (advert) => advert.id,
      advert.id,
    );
  }
}

final advertListProvider =
    NotifierProvider<AdvertListNotifier, AsyncValue<List<AdvertComplete>>>(
      AdvertListNotifier.new,
    );

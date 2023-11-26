import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AdvertiserListNotifier extends ListNotifier2<AdvertiserComplete> {
  final Openapi advertiserRepository;
  AdvertiserListNotifier({required this.advertiserRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AdvertiserComplete>>> loadAllAdvertiserList() async {
    return await loadList(advertiserRepository.advertAdvertisersGet);
  }

  Future<AsyncValue<List<AdvertiserComplete>>> loadMyAdvertiserList() async {
    return await loadList(advertiserRepository.advertMeAdvertisersGet);
  }

  Future<bool> addAdvertiser(AdvertiserComplete advertiser) async {
    return await add(
        (advertiser) async => advertiserRepository.advertAdvertisersPost(
                body: AdvertiserBase(
              name: advertiser.name,
              groupManagerId: advertiser.groupManagerId,
            )),
        advertiser);
  }

  Future<bool> updateAdvertiser(AdvertiserComplete advertiser) async {
    return await update(
        (advertiser) async =>
            advertiserRepository.advertAdvertisersAdvertiserIdPatch(
                advertiserId: advertiser.id,
                body: AdvertiserUpdate(
                  name: advertiser.name,
                  groupManagerId: advertiser.groupManagerId,
                )),
        (advertisers, advertiser) => advertisers
          ..[advertisers.indexWhere((i) => i.id == advertiser.id)] = advertiser,
        advertiser);
  }

  Future<bool> deleteAdvertiser(AdvertiserComplete advertiser) async {
    return await delete(
        (advertiserId) async  => advertiserRepository.advertAdvertsAdvertIdDelete(advertId: advertiserId),
        (adverts, advert) => adverts..removeWhere((i) => i.id == advert.id),
        advertiser.id,
        advertiser);
  }
}

final advertiserListProvider = StateNotifierProvider<AdvertiserListNotifier,
    AsyncValue<List<AdvertiserComplete>>>(
  (ref) {
    final advertiserRepository = ref.watch(repositoryProvider);
    AdvertiserListNotifier advertiserListNotifier =
        AdvertiserListNotifier(advertiserRepository: advertiserRepository);
    tokenExpireWrapperAuth(ref, () async {
      await advertiserListNotifier.loadAllAdvertiserList();
    });
    return advertiserListNotifier;
  },
);

final userAdvertiserListProvider = StateNotifierProvider<AdvertiserListNotifier,
    AsyncValue<List<AdvertiserComplete>>>(
  (ref) {
    final advertiserRepository = ref.watch(repositoryProvider);
    AdvertiserListNotifier advertiserListNotifier =
        AdvertiserListNotifier(advertiserRepository: advertiserRepository);
    tokenExpireWrapperAuth(ref, () async {
      await advertiserListNotifier.loadMyAdvertiserList();
    });
    return advertiserListNotifier;
  },
);

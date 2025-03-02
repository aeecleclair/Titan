import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/advert/adapters/advertiser.dart';

class AdvertiserListNotifier extends ListNotifierAPI<AdvertiserComplete> {
  final Openapi advertiserRepository;
  AdvertiserListNotifier({required this.advertiserRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AdvertiserComplete>>> loadAllAdvertiserList() async {
    return await loadList(advertiserRepository.advertAdvertisersGet);
  }

  Future<AsyncValue<List<AdvertiserComplete>>> loadMyAdvertiserList() async {
    return await loadList(advertiserRepository.advertMeAdvertisersGet);
  }

  Future<bool> addAdvertiser(AdvertiserBase advertiser) async {
    return await add(
      () => advertiserRepository.advertAdvertisersPost(body: advertiser),
      advertiser,
    );
  }

  Future<bool> updateAdvertiser(AdvertiserComplete advertiser) async {
    return await update(
      () => advertiserRepository.advertAdvertisersAdvertiserIdPatch(
        advertiserId: advertiser.id,
        body: advertiser.toAdvertiserUpdate(),
      ),
      (advertiser) => advertiser.id,
      advertiser,
    );
  }

  Future<bool> deleteAdvertiser(String advertiserId) async {
    return await delete(
      () => advertiserRepository.advertAdvertisersAdvertiserIdDelete(
        advertiserId: advertiserId,
      ),
      (a) => a.id,
      advertiserId,
    );
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

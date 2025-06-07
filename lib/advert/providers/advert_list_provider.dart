import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/repositories/advert_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AdvertListNotifier extends ListNotifier<Advert> {
  final AdvertRepository repository;
  AdvertListNotifier(this.repository) : super(const AsyncValue.loading());

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
      final repository = ref.watch(advertRepository);
      final notifier = AdvertListNotifier(repository);
      tokenExpireWrapperAuth(ref, () => notifier.loadAdverts());
      return notifier;
    });

final singleAdvertProvider = Provider.family<AsyncValue<Advert?>, String>((
  ref,
  id,
) {
  return ref.watch(
    advertListProvider.select((value) {
      return value.whenData(
        (adverts) => adverts.firstWhereOrNull((advert) => advert.id == id),
      );
    }),
  );
});

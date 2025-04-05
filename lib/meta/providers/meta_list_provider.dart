import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/meta/repositories/meta_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MetaListNotifier extends ListNotifier<Advert> {
  MetaRepository repository = MetaRepository();
  bool _hasMore = true; // Indique s'il reste des données à charger
  int _page = 0; // Page actuelle ou offset
  final int _limit = 10; // Nombre d'éléments par page

  MetaListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Advert>>> loadMetas() async {
    return await loadList(repository.getMetas);
  }

  Future<bool> addMeta(Advert advert) async {
    return await add(repository.addMeta, advert);
  }

  /*Future<void> loadMoreMetas() async {
    if (!_hasMore) return; // Ne charge pas si toutes les données sont déjà récupérées

    final result = await addAll(
      (currentList) => repository.getMetas(
        limit: _limit,
        after: currentList.isNotEmpty ? currentList.last.id : null,
      ),
      state.value ?? [], // Passe la liste actuelle comme paramètre
    );

    if (!result) {
      _hasMore = false; // Plus de données à charger si l'ajout échoue
    } else {
      _page++; // Passe à la page suivante
    }
  }*/

  Future<bool> updateAdvert(Advert advert) async {
    return await update(
      repository.updateMeta,
      (adverts, advert) =>
          adverts..[adverts.indexWhere((b) => b.id == advert.id)] = advert,
      advert,
    );
  }

  Future<bool> deleteAdvert(Advert advert) async {
    return await delete(
      repository.deleteMeta,
      (adverts, advert) => adverts..removeWhere((b) => b.id == advert.id),
      advert.id,
      advert,
    );
  }
}

final metaListProvider =
    StateNotifierProvider<MetaListNotifier, AsyncValue<List<Advert>>>((ref) {
  final token = ref.watch(tokenProvider);
  MetaListNotifier notifier = MetaListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadMetas();
  });
  return notifier;
});

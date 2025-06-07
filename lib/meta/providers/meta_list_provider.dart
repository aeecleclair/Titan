import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/meta/class/meta.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/meta/repositories/meta_repository.dart';
import 'package:myecl/meta/repositories/advert_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
// Ajout des imports pour Event et Shotgun
import 'package:myecl/event/class/event.dart';

class MetaListNotifier<T extends Meta> extends ListNotifier<T> {
  bool _hasMore = true; // Indique s'il reste des données à charger
  int _page = 0; // Page actuelle ou offset
  final int _limit = 10; // Nombre d'éléments par page
  final MetaRepository<T> repository; // Repository for Meta operations

  MetaListNotifier({required String token, required this.repository})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<T>>> loadMetas() async {
    return await loadList(repository.getMetas);
  }

  Future<bool> addMeta(T meta) async {
    return await add(repository.addMeta, meta);
  }

  Future<void> loadMoreMetas() async {
    if (!_hasMore)
      return; // Ne charge pas si toutes les données sont déjà récupérées

    final result = await appendAll(
      (currentList) => repository.getMetas(
        limit: _limit,
        after: currentList.isNotEmpty ? currentList.last.id : null,
      ),
      state.value ?? [],
    );

    if (!result) {
      _hasMore =
          false; // Plus de données à charger si l'ajout échoue ou si la nouvelle liste est vide
    } else {
      _page++; // Passe à la page suivante
    }
  }

  Future<bool> updateMeta(T meta) async {
    return await update(
      repository.updateMeta,
      (metas, mta) => metas..[metas.indexWhere((b) => b.id == meta.id)] = meta,
      meta,
    );
  }

  Future<bool> deleteMeta(T meta) async {
    return await delete(
      repository.deleteMeta,
      (metas, meta) => metas..removeWhere((b) => b.id == meta.id),
      meta.id,
      meta,
    );
  }
}

// Fonction helper pour factoriser la création des providers
StateNotifierProvider<MetaListNotifier<T>, AsyncValue<List<T>>>
    createMetaProvider<T extends Meta>(
  MetaRepository<T> repository,
) {
  return StateNotifierProvider<MetaListNotifier<T>, AsyncValue<List<T>>>((ref) {
    final token = ref.watch(tokenProvider);
    repository.setToken(token);
    final notifier = MetaListNotifier<T>(token: token, repository: repository);
    tokenExpireWrapperAuth(ref, () async {
      await notifier.loadMetas();
    });
    return notifier;
  });
}

// Déclaration des providers
final advertListProvider = createMetaProvider<Meta>(AdvertRepository());
//final eventsListProvider = createMetaProvider<Event>(EventRepository());
//final shotgunListProvider = createMetaProvider<Shotgun>(ShotgunRepository());

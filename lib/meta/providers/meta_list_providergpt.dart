import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/meta/repositories/meta_repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MetaListNotifier extends StateNotifier<AsyncValue<List<Advert>>> {
  MetaRepository repository = MetaRepository();
  MetaListNotifier({required String token}) : super(const AsyncValue.data([])) {
    // Initialize with an empty list
    repository.setToken(token);
  }

  String? _currentAfter; // Cursor for pagination
  final int _limit = 20; // Number of items per request
  bool _hasMore = true; // Indicates if more data is available

  Future<void> loadAdverts() async {
    // Reset pagination
    _currentAfter = null;
    _hasMore = true;
    state = const AsyncValue.data([]); // Reset state to an empty list
    try {
      final newAdverts =
          await _fetchAdverts(limit: _limit, after: _currentAfter);
      state = AsyncValue.data(newAdverts);
      if (newAdverts.isNotEmpty) {
        _currentAfter = newAdverts.last.id; // Update cursor
      } else {
        _hasMore = false; // No more data
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> loadMoreAdverts() async {
    if (!_hasMore) return; // Do not load if all data is already fetched
    final previousData = state.value ?? []; // Preserve old data
    try {
      final newAdverts =
          await _fetchAdverts(limit: _limit, after: _currentAfter);
      if (newAdverts.isNotEmpty) {
        state = AsyncValue.data(
            [...previousData, ...newAdverts]); // Append new data to old data
        _currentAfter = newAdverts.last.id; // Update cursor
      } else {
        _hasMore = false; // No more data
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<List<Advert>> _fetchAdverts(
      {required int limit, String? after}) async {
    // Simulate an API request with limit and after
    final response = await repository.getMetas(limit: limit, after: after);
    return response; // Return the list of adverts
  }
}

final metaListProvider =
    StateNotifierProvider<MetaListNotifier, AsyncValue<List<Advert>>>((ref) {
  final token = ref.watch(tokenProvider);
  MetaListNotifier notifier = MetaListNotifier(token: token);
  Future(() async {
    tokenExpireWrapperAuth(ref, () async {
      await notifier.loadAdverts();
    });
  });
  return notifier;
});

/* 
final advertListProvider =
    StateNotifierProvider<AdvertListNotifier, AsyncValue<List<Advert>>>((ref) {
  final token = ref.watch(tokenProvider);
  AdvertListNotifier notifier = AdvertListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadAdverts();
  });
  return notifier;
});
*/

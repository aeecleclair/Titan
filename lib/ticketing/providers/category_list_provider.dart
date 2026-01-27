import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/ticketing/class/category.dart';
import 'package:titan/ticketing/repositories/category_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class CategoryListNotifier extends ListNotifier<Category> {
  CategoryRepository repository = CategoryRepository();
  CategoryListNotifier({required String token, required String eventId})
    : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Category>>> loadCategories(String eventId) async {
    return await loadList(() => repository.getAllCategory(eventId));
  }
}

final categoryListProvider =
    StateNotifierProvider<CategoryListNotifier, AsyncValue<List<Category>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      CategoryListNotifier notifier = CategoryListNotifier(
        token: token,
        eventId: '',
      );
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadCategories(''); //TO DO: pass eventId
      });
      return notifier;
    });

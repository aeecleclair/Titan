import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/paiement/repositories/users_me_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class MyStoresNotifier extends ListNotifier<Store> {
  final UsersMeRepository usersMeRepository;
  MyStoresNotifier({required this.usersMeRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Store>>> getMyStores() async {
    return await loadList(usersMeRepository.getMyStores);
  }
}

final myStoresProvider =
    StateNotifierProvider<MyStoresNotifier, AsyncValue<List<Store>>>((ref) {
  final myStoresRepository = ref.watch(usersMeRepositoryProvider);
  return MyStoresNotifier(usersMeRepository: myStoresRepository)..getMyStores();
});

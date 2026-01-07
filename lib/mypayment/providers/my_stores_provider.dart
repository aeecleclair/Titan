import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/class/user_store.dart';
import 'package:titan/mypayment/repositories/users_me_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class MyStoresNotifier extends ListNotifier<UserStore> {
  final UsersMeRepository usersMeRepository;
  MyStoresNotifier({required this.usersMeRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<UserStore>>> getMyStores() async {
    return await loadList(usersMeRepository.getMyStores);
  }
}

final myStoresProvider =
    StateNotifierProvider<MyStoresNotifier, AsyncValue<List<UserStore>>>((ref) {
      final myStoresRepository = ref.watch(usersMeRepositoryProvider);
      return MyStoresNotifier(usersMeRepository: myStoresRepository)
        ..getMyStores();
    });

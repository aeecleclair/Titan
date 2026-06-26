import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class MyStoresNotifier extends ListNotifierAPI<UserStore> {
  Openapi get usersMeRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<UserStore>> build() {
    getMyStores();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<UserStore>>> getMyStores() async {
    return await loadList(usersMeRepository.mypaymentUsersMeStoresGet);
  }
}

final myStoresProvider =
    NotifierProvider<MyStoresNotifier, AsyncValue<List<UserStore>>>(
      MyStoresNotifier.new,
    );

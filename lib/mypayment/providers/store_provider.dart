import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class StoreProvider extends Notifier<UserStore> {
  @override
  UserStore build() {
    return UserStore.empty();
  }

  void updateStore(UserStore store) {
    state = store;
  }
}

final storeProvider = NotifierProvider<StoreProvider, UserStore>(
  StoreProvider.new,
);

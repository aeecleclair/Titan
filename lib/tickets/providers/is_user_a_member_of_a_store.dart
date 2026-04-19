import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/providers/my_stores_provider.dart';

final isUserAMemberOfAStoreProvider = Provider<bool>((ref) {
  final myStores = ref.watch(myStoresProvider);
  return myStores.maybeWhen(
    data: (stores) => stores.isNotEmpty,
    orElse: () => false,
  );
});

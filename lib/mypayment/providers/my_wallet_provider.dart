import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class MyWalletNotifier extends SingleNotifierAPI<Wallet> {
  Openapi get usersMeRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<Wallet> build() {
    getMyWallet();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<Wallet>> getMyWallet() async {
    return await load(usersMeRepository.mypaymentUsersMeWalletGet);
  }
}

final myWalletProvider = NotifierProvider<MyWalletNotifier, AsyncValue<Wallet>>(
  MyWalletNotifier.new,
);

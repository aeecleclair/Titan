import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/class/wallet.dart';
import 'package:titan/paiement/repositories/users_me_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class MyWalletNotifier extends SingleNotifier<Wallet> {
  final UsersMeRepository usersMeRepository;
  MyWalletNotifier({required this.usersMeRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<Wallet>> getMyWallet() async {
    return await load(usersMeRepository.getMyWallet);
  }
}

final myWalletProvider =
    StateNotifierProvider<MyWalletNotifier, AsyncValue<Wallet>>((ref) {
      final usersMeRepository = ref.watch(usersMeRepositoryProvider);
      return MyWalletNotifier(usersMeRepository: usersMeRepository)
        ..getMyWallet();
    });

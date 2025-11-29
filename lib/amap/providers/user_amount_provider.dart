import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/cash.dart';
import 'package:titan/amap/repositories/amap_user_repository.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class UserCashNotifier extends SingleNotifier<Cash> {
  final AmapUserRepository amapUserRepository;
  UserCashNotifier({required this.amapUserRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<Cash>> loadCashByUser(String userId) async {
    return await load(() async => amapUserRepository.getCashByUser(userId));
  }

  Future updateCash(int amount) async {
    state.when(
      data: (cash) {
        final newCash = cash.copyWith(balance: cash.balance + amount);
        state = AsyncValue.data(newCash);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
      loading: () {
        state = const AsyncValue.error(
          "Cannot update cash while loading",
          StackTrace.empty,
        );
      },
    );
  }
}

final userAmountProvider =
    StateNotifierProvider<UserCashNotifier, AsyncValue<Cash>>((ref) {
      final AmapUserRepository amapUserRepository = ref.watch(
        amapUserRepositoryProvider,
      );
      UserCashNotifier userCashNotifier = UserCashNotifier(
        amapUserRepository: amapUserRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        final userId = ref.watch(idProvider);
        userId.whenData(
          (value) async => await userCashNotifier.loadCashByUser(value),
        );
      });
      return userCashNotifier;
    });

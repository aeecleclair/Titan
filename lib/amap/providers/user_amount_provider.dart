import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/repositories/amap_user_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserCashNotifier extends SingleNotifier<Cash> {
  final AmapUserRepository amapUserRepository;
  UserCashNotifier({required this.amapUserRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<Cash>> loadCashByUser(String userId) async {
    return await load(() async => amapUserRepository.getCashByUser(userId));
  }

  Future updateCash(double amount) async {
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/checkout.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/repositories/checkout_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class CheckoutNotifier extends SingleNotifier<Checkout> {
  final CheckoutRepository _checkoutRepository = CheckoutRepository();
  CheckoutNotifier({required String token})
    : super(const AsyncValue.loading()) {
    _checkoutRepository.setToken(token);
  }

  Future<bool> createCheckout(Checkout checkout, Shotgun shotgun) async {
    return await add(
      (c) => _checkoutRepository.createCheckout(c, shotgun),
      checkout,
    );
  }
}

final checkoutProvider =
    StateNotifierProvider<CheckoutNotifier, AsyncValue<Checkout>>((ref) {
      final token = ref.watch(tokenProvider);
      final notifier = CheckoutNotifier(token: token);
      return notifier;
    });

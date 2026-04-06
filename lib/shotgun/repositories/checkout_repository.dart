import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/checkout.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/tools/repository/repository.dart';

class CheckoutRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tickets/";

  Future<Checkout> createCheckout(Checkout checkout, Shotgun shotgun) async {
    return Checkout.fromJson(
      await create(checkout.toJson(), suffix: 'events/${shotgun.id}/checkout'),
    );
  }
}

final checkoutRepositoryProvider = Provider<CheckoutRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return CheckoutRepository()..setToken(token);
});

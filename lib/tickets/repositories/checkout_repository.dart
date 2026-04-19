import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/class/checkout.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tools/repository/repository.dart';

class CheckoutRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tickets/";

  Future<Checkout> createCheckout(
    Checkout checkout,
    TicketEvent ticketEvent,
  ) async {
    return Checkout.fromJson(
      await create(
        checkout.toJson(),
        suffix: 'events/${ticketEvent.id}/checkout',
      ),
    );
  }
}

final checkoutRepositoryProvider = Provider<CheckoutRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return CheckoutRepository()..setToken(token);
});

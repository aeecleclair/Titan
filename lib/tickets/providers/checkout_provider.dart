import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/class/checkout.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/checkout_repository.dart';

/// État de la création d'un checkout
class CheckoutCreationState {
  final bool isCreating;
  final Checkout? checkout;
  final String? error;
  final bool isSuccess;

  const CheckoutCreationState({
    this.isCreating = false,
    this.checkout,
    this.error,
    this.isSuccess = false,
  });

  CheckoutCreationState.initial() : this();

  CheckoutCreationState copyWith({
    bool? isCreating,
    Checkout? checkout,
    String? error,
    bool? isSuccess,
  }) {
    return CheckoutCreationState(
      isCreating: isCreating ?? this.isCreating,
      checkout: checkout ?? this.checkout,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class CheckoutNotifier extends StateNotifier<CheckoutCreationState> {
  final CheckoutRepository _checkoutRepository = CheckoutRepository();

  CheckoutNotifier({required String token})
    : super(CheckoutCreationState.initial()) {
    _checkoutRepository.setToken(token);
  }

  Future<void> createCheckout(Checkout checkout, TicketEvent ticketEvent) async {
    state = state.copyWith(
      isCreating: true,
      error: null,
      isSuccess: false,
      checkout: null,
    );

    try {
      final createdCheckout = await _checkoutRepository.createCheckout(
        checkout,
        (ticketEvent),
      );
      state = state.copyWith(
        isCreating: false,
        checkout: createdCheckout,
        isSuccess: true,
      );
    } catch (e) {
      state = state.copyWith(
        isCreating: false,
        error: e.toString(),
        isSuccess: false,
      );
    }
  }

  void reset() {
    state = CheckoutCreationState.initial();
  }
}

final checkoutProvider =
    StateNotifierProvider<CheckoutNotifier, CheckoutCreationState>((ref) {
      final token = ref.watch(tokenProvider);
      final notifier = CheckoutNotifier(token: token);
      return notifier;
    });

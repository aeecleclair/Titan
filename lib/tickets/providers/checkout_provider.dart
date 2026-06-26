import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

/// État de la création d'un checkout
class CheckoutCreationState {
  final bool isCreating;
  final CheckoutResponse? checkout;
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
    CheckoutResponse? checkout,
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
  final Openapi client;

  CheckoutNotifier({required this.client})
    : super(CheckoutCreationState.initial());

  Future<void> createCheckout(Checkout checkout, String eventId) async {
    state = state.copyWith(
      isCreating: true,
      error: null,
      isSuccess: false,
      checkout: null,
    );

    try {
      final response = await client.ticketsEventsEventIdCheckoutPost(
        eventId: eventId,
        body: checkout,
      );
      if (!response.isSuccessful) {
        throw Exception(response.error?.toString() ?? 'Checkout failed');
      }
      state = state.copyWith(
        isCreating: false,
        checkout: response.body!,
        isSuccess: true,
      );
    } catch (e) {
      final errorString = e.toString();
      String errorKey;
      if (errorString.contains('Session is sold out')) {
        errorKey = 'ticketsSessionSoldOut';
      } else {
        errorKey = errorString;
      }
      state = state.copyWith(
        isCreating: false,
        error: errorKey,
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
      return CheckoutNotifier(client: ref.watch(repositoryProvider));
    });

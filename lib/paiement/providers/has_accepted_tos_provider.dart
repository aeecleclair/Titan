import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/providers/tos_provider.dart';

class HasAcceptedTosNotifier extends StateNotifier<bool> {
  final bool defaultValue;
  HasAcceptedTosNotifier(this.defaultValue) : super(defaultValue);

  void update(bool s) {
    state = s;
  }
}

final hasAcceptedTosProvider =
    StateNotifierProvider.autoDispose<HasAcceptedTosNotifier, bool>((ref) {
      final tos = ref.watch(tosProvider);
      return tos.maybeWhen(
        orElse: () => HasAcceptedTosNotifier(false),
        data: (value) => HasAcceptedTosNotifier(
          value.acceptedTosVersion == value.latestTosVersion,
        ),
      );
    });

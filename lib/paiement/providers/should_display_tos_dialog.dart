import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/providers/tos_provider.dart';

class ShouldDisplayTosDialog extends StateNotifier<bool> {
  final bool defaultValue;
  ShouldDisplayTosDialog(this.defaultValue) : super(defaultValue);

  void update(bool s) {
    state = s;
  }
}

final shouldDisplayTosDialogProvider =
    StateNotifierProvider.autoDispose<ShouldDisplayTosDialog, bool>((ref) {
      final tos = ref.watch(tosProvider);
      return tos.maybeWhen(
        orElse: () => ShouldDisplayTosDialog(false),
        data: (value) => ShouldDisplayTosDialog(
          value.acceptedTosVersion != value.latestTosVersion,
        ),
      );
    });

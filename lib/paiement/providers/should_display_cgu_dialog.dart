import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/providers/cgu_provider.dart';

class ShouldDisplayCguDialog extends StateNotifier<bool> {
  final bool defaultValue;
  ShouldDisplayCguDialog(this.defaultValue) : super(defaultValue);

  void update(s) {
    state = s;
  }
}

final shouldDisplayCguDialogProvider =
    StateNotifierProvider.autoDispose<ShouldDisplayCguDialog, bool>((ref) {
  final cgu = ref.watch(cguProvider);
  return cgu.maybeWhen(
    orElse: () => ShouldDisplayCguDialog(false),
    data: (value) => ShouldDisplayCguDialog(
        value.acceptedCguVersion != value.latestCguVersion,),
  );
});

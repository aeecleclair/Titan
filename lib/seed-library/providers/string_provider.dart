import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/seed-library/tools/constants.dart';

final searchFilterProvider = StateNotifierProvider<StringNotifier, String>((
  ref,
) {
  return StringNotifier();
});

final startMonthProvider = StateNotifierProvider<StringNotifier, String>((ref) {
  return StringNotifier();
});

final endMonthProvider = StateNotifierProvider<StringNotifier, String>((ref) {
  return StringNotifier();
});

final seasonFilterProvider = StateNotifierProvider<StringNotifier, String>((
  ref,
) {
  return StringNotifier(init: SeedLibraryTextConstants.all);
});

class StringNotifier extends StateNotifier<String> {
  StringNotifier({String? init}) : super(init ?? "");

  void setString(String i) {
    state = i;
  }
}

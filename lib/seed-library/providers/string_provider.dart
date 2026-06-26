import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/seed-library/tools/constants.dart';

final searchFilterProvider = NotifierProvider<StringNotifier, String>(
  StringNotifier.new,
);

final startMonthProvider = NotifierProvider<StringNotifier, String>(
  StringNotifier.new,
);

final endMonthProvider = NotifierProvider<StringNotifier, String>(
  StringNotifier.new,
);

final seasonFilterProvider = NotifierProvider<SeasonStringNotifier, String>(
  SeasonStringNotifier.new,
);

class StringNotifier extends Notifier<String> {
  @override
  String build() => "";

  void setString(String i) {
    state = i;
  }
}

class SeasonStringNotifier extends Notifier<String> {
  @override
  String build() => SeedLibraryTextConstants.all;

  void setString(String i) {
    state = i;
  }
}

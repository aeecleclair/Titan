import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/functions.dart';

class MinimalHyperionVersionNotifier extends Notifier<String> {
  @override
  String build() {
    loadVersionFromStorage();
    return "";
  }

  Future<String> loadVersionFromStorage() async {
    state = await getMinimalHyperionVersion();
    return state;
  }
}

final minimalHyperionVersionProvider =
    NotifierProvider<MinimalHyperionVersionNotifier, String>(
      MinimalHyperionVersionNotifier.new,
    );

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/functions.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MinimalHyperionVersionNotifier extends StateNotifier<String> {
  late PackageInfo packageInfo;
  MinimalHyperionVersionNotifier() : super("");

  Future<String> loadVersionFromStorage() async {
    state = await getMinimalHyperionVersion();
    return state;
  }
}

final minimalHyperionVersionProvider =
    StateNotifierProvider<MinimalHyperionVersionNotifier, String>((ref) {
      final notifier = MinimalHyperionVersionNotifier();
      notifier.loadVersionFromStorage();
      return notifier;
    });

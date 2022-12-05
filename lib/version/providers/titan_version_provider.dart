import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TitanVersionNotfier extends StateNotifier<String> {
  late PackageInfo packageInfo;
  TitanVersionNotfier() : super('0.0.0');

  Future<String> loadVersionFromStorage() async {
    packageInfo = await PackageInfo.fromPlatform();
    state = packageInfo.version;
    return state;
  }
}

final titanVersionProvider =
    StateNotifierProvider<TitanVersionNotfier, String>((ref) {
  final notifier = TitanVersionNotfier();
  notifier.loadVersionFromStorage();
  return notifier;
});

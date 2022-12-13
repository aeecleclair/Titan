import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TitanVersionNotfier extends StateNotifier<int> {
  late PackageInfo packageInfo;
  TitanVersionNotfier() : super(0);

  Future<int> loadVersionFromStorage() async {
    packageInfo = await PackageInfo.fromPlatform();
    state = int.parse(packageInfo.buildNumber);
    return state;
  }
}

final titanVersionProvider =
    StateNotifierProvider<TitanVersionNotfier, int>((ref) {
  final notifier = TitanVersionNotfier();
  notifier.loadVersionFromStorage();
  return notifier;
});

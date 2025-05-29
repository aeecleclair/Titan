import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TitanVersionNotifier extends StateNotifier<int> {
  late PackageInfo packageInfo;
  TitanVersionNotifier() : super(0);

  Future<int> loadVersionFromStorage() async {
    packageInfo = await PackageInfo.fromPlatform();
    state = int.parse(packageInfo.buildNumber);
    return state;
  }
}

final titanVersionProvider = StateNotifierProvider<TitanVersionNotifier, int>((
  ref,
) {
  final notifier = TitanVersionNotifier();
  notifier.loadVersionFromStorage();
  return notifier;
});

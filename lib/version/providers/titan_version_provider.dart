import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TitanVersionNotifier extends Notifier<int> {
  late PackageInfo packageInfo;

  @override
  int build() {
    loadVersionFromStorage();
    return 0;
  }

  Future<int> loadVersionFromStorage() async {
    packageInfo = await PackageInfo.fromPlatform();
    state = int.parse(packageInfo.buildNumber);
    return state;
  }
}

final titanVersionProvider = NotifierProvider<TitanVersionNotifier, int>(
  TitanVersionNotifier.new,
);

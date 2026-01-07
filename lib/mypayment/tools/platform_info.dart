import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

Future<String> getPlatformInfo() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String platform = 'Unknown';
  try {
    if (kIsWeb) {
      platform = 'Web';
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      platform = 'Android ${androidInfo.product}';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      platform = 'iOS ${iosInfo.name}';
    }
  } catch (e) {
    platform = 'Failed to get platform version';
  }
  return platform;
}

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

// This code was taken from the plugin plausible_analytics and adapted
// We should switch to a plugin when one will work

/// Plausible class. Use the constructor to set the parameters.
class Plausible {
  /// The url of your plausible server e.g. https://plausible.io
  final String serverUrl;
  final String domain;

  /// Constructor
  Plausible(serverUrl, this.domain)
      // Remove trailing slash '/'
      : serverUrl = serverUrl.endsWith("/")
            ? serverUrl.substring(0, serverUrl.length - 1)
            : serverUrl;

  /// Post event to plausible
  Future<int> event(String page) async {
    // https://plausible.io/docs/events-api#request-body-json-parameters
    page = "app://localhost/$page";

    final Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    // browser adds by default the User-Agent header so we should not overwrite it
    if (!kIsWeb) {
      final packageInfo = await PackageInfo.fromPlatform();
      final deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        headers["User-Agent"] =
            "${packageInfo.appName}/${packageInfo.version} Android/${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt}; ${androidInfo.model} Build/${androidInfo.id})";
      }
      if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        headers["User-Agent"] =
            "${packageInfo.appName}/${packageInfo.version} iOS/${iosInfo.systemVersion} (${iosInfo.model})";
      }
    }

    final Map<String, String> body = {
      "domain": domain,
      "name": "pageview",
      "url": page,
    };

    final response = await http.post(
      Uri.parse('$serverUrl/api/event'),
      body: jsonEncode(body),
      headers: headers,
    );

    return response.statusCode;
  }
}

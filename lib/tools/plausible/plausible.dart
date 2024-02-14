import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ua_client_hints/ua_client_hints.dart';

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

    if (!kIsWeb) {
      // browser adds by default this header so we should not overwrite it
      headers["User-Agent"] = await userAgent();
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

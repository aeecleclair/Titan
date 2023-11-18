import 'dart:async';

import 'package:chopper/chopper.dart';

class MyRequestInterceptor implements RequestInterceptor {
  final String? token;

  MyRequestInterceptor(this.token);

  @override
  FutureOr<Request> onRequest(Request request) {
    final updatedRequest = applyHeader(
      request,
      'Authorization',
      'Bearer $token',
      // Do not override existing header
      override: false,
    );

    print(
      '[AuthInterceptor] accessToken: $token',
    );

    return updatedRequest;
  }
}

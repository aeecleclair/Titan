import 'dart:async';

import 'package:chopper/chopper.dart';

class AuthInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    return applyHeader(
        request, 'Content-Type', 'application/x-www-form-urlencoded',
        override: true);
  }
}

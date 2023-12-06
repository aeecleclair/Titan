import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';

class AuthInterceptor implements RequestInterceptor {
  final String token;
  AuthInterceptor({required this.token});

  @override
  FutureOr<Request> onRequest(Request request) {
    return applyHeader(request, 'Authorization', 'Bearer $token',
        override: true);
  }
}

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  final token = ref.watch(tokenProvider);
  return AuthInterceptor(token: token);
});
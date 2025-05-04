import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';

class AuthInterceptor implements HeadersInterceptor {
  final String token;

  AuthInterceptor({required this.token});

  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer $token',
      };

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final request = applyHeader(
      chain.request,
      'Authorization',
      'Bearer $token',
      override: true,
    );

    return chain.proceed(request);
  }
}

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  final token = ref.watch(tokenProvider);
  return AuthInterceptor(token: token);
});

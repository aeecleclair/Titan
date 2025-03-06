import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/logs/logger.dart';

class LogInterceptor implements ResponseInterceptor {
  final Logger logger;
  LogInterceptor({required this.logger});

  @override
  FutureOr<Response> onResponse(Response response) {
    if (response.statusCode >= 400) {
      logger.error(
        "Response: ${response.statusCode} ${response.bodyString}",
      );
    }
    return response;
  }
}

final logInterceptorProvider = Provider<LogInterceptor>((ref) {
  final logger = ref.watch(loggerProvider);
  return LogInterceptor(logger: logger);
});

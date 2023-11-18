import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/interceptors/request_interceptor.dart';

class Repository {
  final String token;
  late Openapi repository;

  Repository({required this.token}) {
    repository = Openapi.create(
      baseUrl:
          Uri.parse(dotenv.env[kDebugMode ? "DEBUG_HOST" : "RELEASE_HOST"]!),
      interceptors: [
        MyRequestInterceptor(token),
      ],
    );
  }
}

import 'package:myecl/generated/openapi.models.swagger.dart';

extension $CineSessionComplete on CineSessionComplete {
  CineSessionBase toCineSessionBase() {
    return CineSessionBase(start: start, duration: duration, name: name, overview: overview);
  }
}
import 'package:titan/generated/openapi.models.swagger.dart';

extension CoreUserSimpleName on CoreUserSimple {
  String getName() {
    if (nickname == null) {
      return '$nickname ($firstname $name)';
    }
    return '$firstname $name';
  }
}

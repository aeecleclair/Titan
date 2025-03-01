import 'package:myecl/generated/openapi.models.swagger.dart';

extension ApplicantName on Applicant {
  String getName() {
    if (nickname == null) {
      return '$nickname ($firstname $name)';
    }
    return '$firstname $name';
  }
}
import 'package:myecl/generated/openapi.models.swagger.dart';

extension $Applicant on Applicant {
  CoreUserSimple toCoreUserSimple() {
    return CoreUserSimple(
      name: name,
      firstname: firstname,
      nickname: nickname,
      id: id,
      accountType: accountType,
      schoolId: schoolId,
    );
  }
}

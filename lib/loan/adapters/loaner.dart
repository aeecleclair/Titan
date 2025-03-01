import 'package:myecl/generated/openapi.models.swagger.dart';

extension $Loaner on Loaner {
  LoanerUpdate toLoanerUpdate() {
    return LoanerUpdate(
      name: name,
      groupManagerId: groupManagerId,
    );
  }
}

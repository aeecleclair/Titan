import 'package:myecl/generated/openapi.models.swagger.dart';

extension $MembershipComplete on MembershipComplete {
  MembershipEdit toMembershipEdit() {
    return MembershipEdit(
      memberOrder: memberOrder,
      roleName: roleName,
      roleTags: roleTags,
    );
  }
}

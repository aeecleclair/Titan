import 'package:myecl/generated/openapi.models.swagger.dart';

extension $CoreGroup on CoreGroup {
  CoreMembership toCoreMembership(CoreUserSimple user) {
    return CoreMembership(userId: user.id, groupId: id);
  }

  CoreMembershipDelete toCoreMembershipDelete(CoreUserSimple user) {
    return CoreMembershipDelete(userId: user.id, groupId: id);
  }
}

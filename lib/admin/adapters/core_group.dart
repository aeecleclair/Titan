import 'package:titan/generated/openapi.models.swagger.dart';

extension $CoreGroup on CoreGroup {
  CoreGroupSimple toCoreGroupSimple() {
    return CoreGroupSimple(name: name, id: id);
  }

  CoreMembership toCoreMembership(CoreUserSimple user) {
    return CoreMembership(userId: user.id, groupId: id);
  }

  CoreMembershipDelete toCoreMembershipDelete(CoreUserSimple user) {
    return CoreMembershipDelete(userId: user.id, groupId: id);
  }
}

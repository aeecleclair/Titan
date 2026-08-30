import 'package:titan/admin/class/user_association_membership_base.dart';
import 'package:titan/user/class/simple_users.dart';

class UserAssociationMembership extends UserAssociationMembershipBase {
  UserAssociationMembership({
    required super.id,
    required super.associationMembershipId,
    required super.userId,
    required super.startDate,
    required super.endDate,
    required this.user,
    required super.documentId,
    required super.documentStatus,
  });
  late final SimpleUser user;

  UserAssociationMembership.fromJson(super.json)
    : user = SimpleUser.fromJson(json['user']),
      super.fromJson();

  @override
  Map<String, dynamic> toJson() {
    final userAssociationMembership = super.toJson();
    userAssociationMembership['user'] = user.toJson();
    return userAssociationMembership;
  }

  UserAssociationMembership.empty() : user = SimpleUser.empty(), super.empty();

  UserAssociationMembership copyWith({
    String? id,
    String? associationMembershipId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    String? documentId,
    DocumentStatus? documentStatus,
    SimpleUser? user,
  }) {
    return UserAssociationMembership(
      id: id ?? this.id,
      associationMembershipId:
          associationMembershipId ?? this.associationMembershipId,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      documentId: documentId ?? this.documentId,
      documentStatus: documentStatus ?? this.documentStatus,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return "UserAssociationMembership {id: $id, associationMembershipId: $associationMembershipId, userId: $userId, startDate: $startDate, endDate: $endDate, documentId: $documentId, documentStatus: $documentStatus, user: $user}";
  }
}

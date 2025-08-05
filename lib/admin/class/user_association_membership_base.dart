import 'package:titan/tools/functions.dart';

class UserAssociationMembershipBase {
  UserAssociationMembershipBase({
    required this.id,
    required this.associationMembershipId,
    required this.userId,
    required this.startDate,
    required this.endDate,
  });
  late final String id;
  late final String associationMembershipId;
  late final String userId;
  late final DateTime startDate;
  late final DateTime endDate;

  UserAssociationMembershipBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    associationMembershipId = json['association_membership_id'];
    userId = json['user_id'];
    startDate = processDateFromAPI(json['start_date']);
    endDate = processDateFromAPI(json['end_date']);
  }

  Map<String, dynamic> toJson() {
    final userAssociationMembership = <String, dynamic>{};
    userAssociationMembership['id'] = id;
    userAssociationMembership['association_membership_id'] =
        associationMembershipId;
    userAssociationMembership['user_id'] = userId;
    userAssociationMembership['start_date'] = processDateToAPIWithoutHour(
      startDate,
    );
    userAssociationMembership['end_date'] = processDateToAPIWithoutHour(
      endDate,
    );
    return userAssociationMembership;
  }

  UserAssociationMembershipBase.empty()
    : id = '',
      associationMembershipId = '',
      userId = '',
      startDate = DateTime(0),
      endDate = DateTime(0);

  @override
  String toString() {
    return "UserAssociationMembership {id: $id, associationMembershipId: $associationMembershipId, userId: $userId, startDate: $startDate, endDate: $endDate}";
  }
}

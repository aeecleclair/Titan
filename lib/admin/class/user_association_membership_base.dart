import 'package:titan/tools/functions.dart';

enum DocumentStatus { pending, approved, rejected }

class UserAssociationMembershipBase {
  UserAssociationMembershipBase({
    required this.id,
    required this.associationMembershipId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.documentId,
    required this.documentStatus,
  });
  late final String id;
  late final String associationMembershipId;
  late final String userId;
  late final DateTime startDate;
  late final DateTime endDate;
  late final String? documentId;
  late final DocumentStatus? documentStatus;

  UserAssociationMembershipBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    associationMembershipId = json['association_membership_id'];
    userId = json['user_id'];
    startDate = processDateFromAPI(json['start_date']);
    endDate = processDateFromAPI(json['end_date']);
    documentId = json['document_id'];
    documentStatus = json['document_status'] != null
        ? DocumentStatus.values.firstWhere(
            (e) => e.name == json['document_status'].toString().toLowerCase(),
          )
        : null;
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
    userAssociationMembership['document_id'] = documentId;
    userAssociationMembership['document_status'] = documentStatus?.name
        .toUpperCase();
    return userAssociationMembership;
  }

  UserAssociationMembershipBase.empty()
    : id = '',
      associationMembershipId = '',
      userId = '',
      startDate = DateTime(0),
      endDate = DateTime(0),
      documentId = null,
      documentStatus = null;

  @override
  String toString() {
    return "UserAssociationMembership {id: $id, associationMembershipId: $associationMembershipId, userId: $userId, startDate: $startDate, endDate: $endDate, documentId: $documentId, documentStatus: $documentStatus}";
  }
}

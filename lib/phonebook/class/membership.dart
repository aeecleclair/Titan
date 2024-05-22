class Membership {
  Membership({
    required this.id,
    required this.associationId,
    required this.memberId,
    required this.rolesTags,
    required this.apparentName,
    required this.mandateYear,
    required this.order,
  });

  late final String id;
  late final String associationId;
  late final String memberId;
  late final List<String> rolesTags;
  late final String apparentName;
  late final int mandateYear;
  late final int order;

  Membership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    associationId = json['association_id'];
    memberId = json['user_id'];
    rolesTags = json['role_tags'].split(";");
    apparentName = json['role_name'];
    mandateYear = json['mandate_year'];
    order = json['member_order'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'association_id': associationId,
      'user_id': memberId,
      'role_tags': rolesTags.join(";"),
      'role_name': apparentName,
      'mandate_year': mandateYear,
      'member_order': order,
    };
    return data;
  }

  Membership copyWith({
    String? id,
    String? associationId,
    String? memberId,
    List<String>? rolesTags,
    String? apparentName,
    int? mandateYear,
    int? order,
  }) {
    return Membership(
      id: id ?? this.id,
      associationId: associationId ?? this.associationId,
      memberId: memberId ?? this.memberId,
      rolesTags: rolesTags ?? this.rolesTags,
      apparentName: apparentName ?? this.apparentName,
      mandateYear: mandateYear ?? this.mandateYear,
      order: order ?? this.order,
    );
  }

  Membership.empty() {
    id = "";
    associationId = "";
    memberId = "";
    rolesTags = [];
    apparentName = "";
    mandateYear = 0;
    order = 0;
  }

  @override
  String toString() {
    return 'Membership(id: $id, associationId: $associationId, memberId: $memberId, rolesTags: ${rolesTags.join(";")}, apparentName: $apparentName,mandateYear: $mandateYear, order: $order)';
  }
}

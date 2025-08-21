import 'package:titan/phonebook/class/membership.dart';
import 'member.dart';

class CompleteMember {
  CompleteMember({required this.member, required this.memberships});

  late final Member member;
  late final List<Membership> memberships;

  CompleteMember.fromJson(Map<String, dynamic> json) {
    member = Member.fromJson(json);
    memberships = List<Membership>.from(
      json['memberships'].map((membership) {
        return Membership.fromJson(membership);
      }),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'member': member.id,
      'memberships': memberships.map((e) => e.toJson()).toList(),
    };
    return data;
  }

  CompleteMember copyWith({Member? member, List<Membership>? membership}) {
    return CompleteMember(
      member: member ?? this.member,
      memberships: membership ?? memberships,
    );
  }

  CompleteMember.empty() {
    member = Member.empty();
    memberships = [];
  }

  Member toMember() {
    return member;
  }

  @override
  String toString() {
    return 'CompleteMember(member: $member, memberships: $memberships)';
  }

  List<String> getRolesTags(String associationId) {
    return memberships
        .firstWhere((element) => element.associationId == associationId)
        .rolesTags;
  }

  String getName() {
    return "${member.firstname} ${member.name}";
  }
}

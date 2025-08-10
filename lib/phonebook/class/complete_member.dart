import 'package:titan/super_admin/class/account_type.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'member.dart';

class CompleteMember {
  CompleteMember({required this.member, required this.memberships});

  late final Member member;
  late final List<Membership> memberships;

  CompleteMember.fromJson(Map<String, dynamic> json) {
    member = Member(
      name: json['name'],
      firstname: json['firstname'],
      nickname: json['nickname'] ?? "",
      id: json['id'],
      accountType: AccountType(type: json['account_type']),
      email: json['email'],
      phone: json['phone'],
      promotion: json['promo'] ?? 0,
    );
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

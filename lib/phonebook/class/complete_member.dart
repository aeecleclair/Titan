import 'package:myecl/phonebook/class/membership.dart';
import 'member.dart';

class CompleteMember{
  CompleteMember({
    required this.member,
    required this.memberships,
  });

  late final Member member;
  late final List<Membership> memberships;
  

  CompleteMember.fromJSON(Map<String, dynamic> json){
      member = Member.fromJSON(json['user']);
      memberships = json['membership'].map((membership) => Membership.fromJSON(membership)).toList();
      }
    
  Map<String, dynamic> toJSON(){
    final data = <String, dynamic>{
      'member': member.id,
      'membership': memberships.map((e) => e.toJSON()).toList(),
    };
    return data;
  }

  CompleteMember copyWith({
    Member? member,
    List<Membership>? membership,
  }) {
    return CompleteMember(
      member: member ?? this.member,
      memberships: membership ?? memberships,
    );
  }

  CompleteMember.empty(){
    member = Member.empty();
    memberships = [];
  }

  Member toMember(){
    return Member(
      name: member.name,
      firstname: member.firstname,
      nickname: member.nickname,
      id: member.id,
      email: member.email);
  }
}  

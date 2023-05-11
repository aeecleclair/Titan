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
      String name = json['name'];
      String firstname = json['firstname'];
      String nickname = json['nickname'];
      String id = json['id'];
      String email = json['email'];
      String promotion = json['promotion'];
      member = Member(name: name, firstname: firstname, nickname: nickname, id: id, email: email, promotion: promotion);
      memberships = json['memberships'].map((membership) => Membership.fromJSON(membership)).toList();
      }
    
  Map<String, dynamic> toJSON(){
    final data = <String, dynamic>{
      'member': member.id,
      'memberships': memberships.map((e) => e.toJSON()).toList(),
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
      email: member.email,
      promotion: member.promotion,);
  }

  @override
  String toString() {
    return 'CompleteMember(member: $member, memberships: $memberships)';
  }

  List<String> getRolesTags(String associationId){
    return memberships.firstWhere((element) => element.association.id == associationId).rolesTags;
  }
}  

import 'package:flutter/material.dart';
import 'package:myecl/user/class/list_users.dart';

class MemberList extends StatelessWidget {
  final List<SimpleUser> members;
  const MemberList({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Column(children: members.map((e) => Text(e.name)).toList());
  }
}

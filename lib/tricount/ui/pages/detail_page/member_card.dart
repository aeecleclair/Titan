import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tricount/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';

class MemberCard extends StatelessWidget {
  final SimpleUser member;
  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xff1C4668),
            child: Text(
              getAvatarName(member),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          AutoSizeText(
            member.nickname ?? member.firstname,
            style: const TextStyle(
                color: Color(0xff1C4668),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

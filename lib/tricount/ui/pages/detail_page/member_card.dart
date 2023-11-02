import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/user/class/list_users.dart';

class MemberCard extends StatelessWidget {
  final SimpleUser member;
  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final name = member.nickname != null
        ? member.nickname!.substring(0, min(member.nickname!.length, 3))
        : member.firstname.substring(0, min(member.firstname.length, 3));
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xff1C4668),
            child: Text(
              name,
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
          HeroIcon(
            HeroIcons.trash,
            color: Colors.red.shade800,
            size: 30,
          )
        ],
      ),
    );
  }
}

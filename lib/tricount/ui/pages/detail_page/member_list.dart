import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tricount/ui/pages/detail_page/member_card.dart';
import 'package:myecl/user/class/list_users.dart';

class MemberList extends StatelessWidget {
  final List<SimpleUser> members;
  const MemberList({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Row(
          children: [
            const SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  'Participants',
                  style: TextStyle(color: Color(0xff09263D), fontSize: 20),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const HeroIcon(
                HeroIcons.plus,
                color: Color(0xff09263D),
                size: 30,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        ...members.map((e) => MemberCard(member: e))
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tricount/class/balance.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';

class EquilibriumCard extends StatelessWidget {
  final Balance balance;
  final List<SimpleUser> members;
  final bool isLightTheme;
  const EquilibriumCard(
      {super.key,
      required this.balance,
      required this.members,
      this.isLightTheme = false});

  @override
  Widget build(BuildContext context) {
    final from = getMember(members, balance.userId);
    final to = getMember(members, balance.reimbursementId);
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor:
                isLightTheme ? const Color(0xff09263D) : Colors.white,
            child: Text(
              getAvatarName(from),
              style: TextStyle(
                  color: isLightTheme ? Colors.white : const Color(0xff09263D),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          HeroIcon(
            HeroIcons.arrowRight,
            color: isLightTheme ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 30,
            backgroundColor:
                isLightTheme ? const Color(0xff1C4668) : Colors.white,
            child: Text(
              getAvatarName(to),
              style: TextStyle(
                  color: isLightTheme ? Colors.white : const Color(0xff1C4668),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Text(
            "${balance.amount.abs().toStringAsFixed(2)}€",
            style: TextStyle(
                color: isLightTheme ? const Color(0xff09263D) : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/vote/class/members.dart';

class MemberCard extends StatelessWidget {
  final Member member;
  final Function()? onEdit, onDelete;
  final bool isAdmin;
  const MemberCard({
    super.key,
    required this.member,
    this.onEdit,
    this.onDelete,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      id: member.id,
      width: 150,
      height: isAdmin ? 145 : 110,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          AutoSizeText(
            member.nickname ?? member.firstname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 2),
          AutoSizeText(
            member.nickname != null
                ? '${member.firstname} ${member.name}'
                : member.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 2),
          if (!isAdmin) const Spacer(),
          AutoSizeText(
            member.role,
            maxLines: 1,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (isAdmin) const Spacer(),
          if (isAdmin)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onEdit,
                  child: CardButton(
                    color: Colors.grey.shade200,
                    shadowColor: Colors.grey.withValues(alpha: 0.2),
                    child: const HeroIcon(
                      HeroIcons.pencil,
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onDelete,
                  child: const CardButton(
                    color: Colors.black,
                    child: HeroIcon(HeroIcons.trash, color: Colors.white),
                  ),
                ),
              ],
            ),
          SizedBox(height: isAdmin ? 10 : 15),
        ],
      ),
    );
  }
}

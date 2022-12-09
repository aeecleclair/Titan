import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/vote/class/members.dart';

class MemberCard extends StatelessWidget {
  final Member member;
  final Function() onEdit, onDelete;
  final bool isAdmin;
  const MemberCard(
      {super.key,
      required this.member,
      required this.onEdit,
      required this.onDelete,
      this.isAdmin = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 140,
        height: isAdmin ? 160 : 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              AutoSizeText(
                  member.nickname.isEmpty ? member.firstname : member.nickname,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 2),
              AutoSizeText(
                  member.nickname.isNotEmpty
                      ? '${member.firstname} ${member.name}'
                      : member.name,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400)),
              const SizedBox(height: 2),
              if (!isAdmin) const Spacer(),
              AutoSizeText(member.role,
                  maxLines: 1,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              if (isAdmin) const Spacer(),
              if (isAdmin)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(2, 3))
                          ],
                        ),
                        child: const Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(2, 3))
                          ],
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: isAdmin ? 10 : 15),
            ],
          ),
        ),
      ),
    );
  }
}

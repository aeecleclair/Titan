import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class AssociationCard extends HookConsumerWidget {
  const AssociationCard({
    super.key,
    required this.association,
    required this.onClicked,
    this.showMemberRole = false,
    this.member,
  });

  final Association association;
  final VoidCallback onClicked;
  final bool showMemberRole;
  final CompleteMember? member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Membership> assoMembership = [];
    if (member != null) {
      assoMembership = member!.memberships
          .where((memberships) => memberships.associationId == association.id)
          .toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: onClicked,
        child: CardLayout(
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                association.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 1),
              Text(!showMemberRole
                  ? association.kind
                  : member == null
                      ? PhonebookTextConstants.noMember
                      : assoMembership.isEmpty
                          ? PhonebookTextConstants.noMemberRole
                          : assoMembership.first.apparentName)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MemberCard extends HookConsumerWidget {
  const MemberCard(
      {super.key, required this.member, required this.association});

  final CompleteMember member;
  final Association association;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberNotifier = ref.watch(completeMemberProvider.notifier);

    Membership? assoMembership = member.memberships.firstWhereOrNull(
        (memberships) =>
            memberships.associationId == association.id &&
            memberships.mandateYear == association.mandateYear);

    return GestureDetector(
      onTap: () {
        memberNotifier.setCompleteMember(member);
        QR.to(PhonebookRouter.root + PhonebookRouter.memberDetail);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: CardLayout(
          margin: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (member.member.nickname != null) ...[
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    member.member.nickname!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "(${member.member.name} ${member.member.firstname})",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 115, 115, 115),
                    ),
                  ),
                ]),
              ] else
                Text(
                  "${member.member.name} ${member.member.firstname}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              Flexible(
                child: Text(
                  textAlign: TextAlign.right,
                  assoMembership == null
                      ? PhonebookTextConstants.noMemberRole
                      : assoMembership.apparentName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

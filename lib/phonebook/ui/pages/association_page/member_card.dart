import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/copiabled_text.dart';
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

    List<Membership> assoMembership = member.memberships
        .where((memberships) => memberships.associationId == association.id)
        .toList();

    return GestureDetector(
        onTap: () {
          memberNotifier.setCompleteMember(member);
          QR.to(PhonebookRouter.root + PhonebookRouter.memberDetail);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CardLayout(
              margin: EdgeInsets.zero,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  if (!kIsWeb) ...[
                    if (member.member.nickname != null)
                      CopiabledText(
                        member.member.nickname!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        flex: 1,
                      ),
                    CopiabledText(
                      "${member.member.name} ${member.member.firstname}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: member.member.nickname != null
                            ? const Color.fromARGB(255, 115, 115, 115)
                            : Colors.black,
                      ),
                      flex: 1,
                    ),
                    CopiabledText(member.member.email,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        flex: 1),
                    if (member.member.phone != null)
                      CopiabledText(member.member.phone!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          flex: 1),
                    CopiabledText(
                        member.memberships
                            .firstWhere((element) =>
                                element.associationId == association.id)
                            .apparentName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        flex: 1)
                  ] else ...[
                    if (member.member.nickname != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.member.nickname!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${member.member.name} ${member.member.firstname}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 115, 115, 115),
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        "${member.member.name} ${member.member.firstname}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    const Spacer(flex: 1),
                    Text(
                      assoMembership.isEmpty
                          ? PhonebookTextConstants.noMemberRole
                          : assoMembership.first.apparentName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ],
              )),
        ));
  }
}

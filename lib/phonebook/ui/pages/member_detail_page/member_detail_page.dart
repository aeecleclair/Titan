import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/phonebook/ui/pages/member_detail_page/element_field.dart';
import 'package:titan/phonebook/ui/pages/member_detail_page/membership_card.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MemberDetailPage extends HookConsumerWidget {
  const MemberDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberProvider = ref.watch(completeMemberProvider);
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationList = ref.watch(associationListProvider);
    return PhonebookTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: CardLayout(
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    ElementField(
                      label: PhonebookTextConstants.name,
                      value: memberProvider.member.name,
                    ),
                    ElementField(
                      label: PhonebookTextConstants.firstname,
                      value: memberProvider.member.firstname,
                    ),
                    if (memberProvider.member.nickname != null)
                      ElementField(
                        label: PhonebookTextConstants.nickname,
                        value: memberProvider.member.nickname!,
                      ),
                    ElementField(
                      label: PhonebookTextConstants.email,
                      value: memberProvider.member.email,
                    ),
                    if (memberProvider.member.phone != null)
                      ElementField(
                        label: PhonebookTextConstants.phone,
                        value: memberProvider.member.phone!,
                      ),
                    ElementField(
                      label: PhonebookTextConstants.promotion,
                      value: memberProvider.member.promotion == 0
                          ? PhonebookTextConstants.promoNotGiven
                          : memberProvider.member.promotion < 100
                          ? "20${memberProvider.member.promotion}"
                          : memberProvider.member.promotion.toString(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (memberProvider.memberships.isNotEmpty)
              Text(
                memberProvider.memberships.length == 1
                    ? PhonebookTextConstants.association
                    : PhonebookTextConstants.associations,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            const SizedBox(height: 20),
            AsyncChild(
              value: associationList,
              builder: (context, associations) => Column(
                children: [
                  ...memberProvider.memberships.map((membership) {
                    final associationMembership = associations.firstWhere(
                      (association) =>
                          association.id == membership.associationId,
                    );
                    return MembershipCard(
                      association: associationMembership,
                      onClicked: () {
                        associationNotifier.setAssociation(
                          associationMembership,
                        );
                        QR.to(
                          PhonebookRouter.root +
                              PhonebookRouter.associationDetail,
                        );
                      },
                      membership: membership,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

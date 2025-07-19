import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/ui/pages/member_detail_page/element_field.dart';
import 'package:titan/phonebook/ui/pages/member_detail_page/membership_card.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

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
                      label: AppLocalizations.of(context)!.phonebookName,
                      value: memberProvider.member.name,
                    ),
                    ElementField(
                      label: AppLocalizations.of(context)!.phonebookFirstname,
                      value: memberProvider.member.firstname,
                    ),
                    if (memberProvider.member.nickname != null)
                      ElementField(
                        label: AppLocalizations.of(context)!.phonebookNickname,
                        value: memberProvider.member.nickname!,
                      ),
                    ElementField(
                      label: AppLocalizations.of(context)!.phonebookEmail,
                      value: memberProvider.member.email,
                    ),
                    if (memberProvider.member.phone != null)
                      ElementField(
                        label: AppLocalizations.of(context)!.phonebookPhone,
                        value: memberProvider.member.phone!,
                      ),
                    ElementField(
                      label: AppLocalizations.of(context)!.phonebookPromotion,
                      value: memberProvider.member.promotion == 0
                          ? AppLocalizations.of(context)!.phonebookPromoNotGiven
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
                    ? AppLocalizations.of(context)!.phonebookAssociation
                    : AppLocalizations.of(context)!.phonebookAssociations,
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

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/main_page/association_card.dart';
import 'package:myecl/phonebook/ui/pages/member_detail_page/element_field.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MemberDetailPage extends HookConsumerWidget {
  const MemberDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberProvider = ref.watch(completeMemberProvider);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationList = ref.watch(associationListProvider);
    return PhonebookTemplate(
        child: Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Column(children: [
              const Text(PhonebookTextConstants.detail),
              ElementField(
                  label: PhonebookTextConstants.name,
                  value: memberProvider.member.name),
              ElementField(
                  label: PhonebookTextConstants.firstname,
                  value: memberProvider.member.firstname),
              if (memberProvider.member.nickname != null)
                ElementField(
                    label: PhonebookTextConstants.nickname,
                    value: memberProvider.member.nickname!),
              ElementField(
                  label: PhonebookTextConstants.email,
                  value: memberProvider.member.email),
              ElementField(
                  label: PhonebookTextConstants.promotion,
                  value: memberProvider.member.promotion == 0
                      ? PhonebookTextConstants.promoNotGiven
                      : memberProvider.member.promotion < 100
                          ? "20${memberProvider.member.promotion}"
                          : memberProvider.member.promotion.toString()),
              if (memberProvider.memberships.isNotEmpty)
                Text(memberProvider.memberships.length == 1
                    ? PhonebookTextConstants.association
                    : PhonebookTextConstants.associations),
              ...memberProvider.memberships
                  .map((e) => AssociationCard(
                      association: associationList.firstWhere(
                          (association) => association.id == e.associationId),
                      onClicked: () {
                        associationNotifier.setAssociation(
                            associationList.firstWhere((association) =>
                                association.id == e.associationId));
                        QR.to(PhonebookRouter.root +
                            PhonebookRouter.associationDetail);
                      },
                      giveMemberRole: true))
                  .toList(),
            ])));
  }
}

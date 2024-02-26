import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/main_page/association_card.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MemberDetailPage extends HookConsumerWidget {
  const MemberDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberProvider = ref.watch(completeMemberProvider);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    return PhonebookTemplate(
      child:
        Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: Column(children: [
          const Text(PhonebookTextConstants.detail),
          Text("${PhonebookTextConstants.name} ${memberProvider.member.name}"),
          Text(
              "${PhonebookTextConstants.firstname} ${memberProvider.member.firstname}"),
          if (memberProvider.member.nickname != null)
            Text(
                "${PhonebookTextConstants.nickname} ${memberProvider.member.nickname!}"),
          Text(
              "${PhonebookTextConstants.promotion} ${memberProvider.member.promotion}"),
          Text(
              "${PhonebookTextConstants.email} ${memberProvider.member.email}"),
          const Text(PhonebookTextConstants
              .association), //TODO: à changer pour dépendre du nombre d'associatione
          ...memberProvider.memberships.map(
              (e) => AssociationCard(
                association: e.association,
                onClicked: (() {
                  associationNotifier.setAssociation(e.association);
                  QR.to(PhonebookRouter.root +
                      PhonebookRouter.associationDetail);
                }))).toList(),
        ])));
  }
}

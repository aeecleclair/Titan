import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';

class MemberDetailPage extends HookConsumerWidget {
  const MemberDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberProvider = ref.watch(completeMemberProvider);
    return Container(
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
          Column(children: [
            for (var membership in memberProvider.memberships)
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(children: [
                    const Spacer(flex: 1),
                    Text(
                        "${membership.association.name} : ${membership.apparentName}"),
                    const Spacer(flex: 1),
                  ]))
          ]),
        ]));
  }
}

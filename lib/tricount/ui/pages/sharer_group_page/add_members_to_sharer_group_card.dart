import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tricount/providers/sharer_group_member_list_provider.dart';

class AddMembersToSharerGroupCard extends HookConsumerWidget {
  const AddMembersToSharerGroupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroupMemberList = ref.watch(sharerGroupMemberListProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(children: [
        const Row(children: [
          Text(
            "Nom",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          SizedBox(
            width: 150,
            child: Text(
              "Partage des dépenses précédentes",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ]),
        const SizedBox(height: 10),
        ...sharerGroupMemberList.map((member) => Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Chip(
                      label: Text(member.nickname ?? member.firstname),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      backgroundColor: const Color(0xff1C4668)),
                  const Spacer(),
                  SizedBox(
                      width: 150,
                      child: Checkbox(
                        value: false,
                        onChanged: (_) {},
                      ))
                ],
              ),
            ))
      ]),
    );
  }
}

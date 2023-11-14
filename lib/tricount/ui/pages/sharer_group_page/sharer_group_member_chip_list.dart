import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tricount/providers/sharer_group_member_list_provider.dart';
import 'package:myecl/user/class/list_users.dart';

class SharerGroupMemberChipList extends HookConsumerWidget {
  final void Function(SimpleUser)? onDeleted;
  final bool canDelete;
  const SharerGroupMemberChipList({super.key, required this.onDeleted, this.canDelete = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroupMemberList = ref.watch(sharerGroupMemberListProvider);
    return Wrap(
        children: sharerGroupMemberList
            .map((sharerGroupMember) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Chip(
                    label: Text(sharerGroupMember.nickname != null
                        ? sharerGroupMember.nickname!
                        : sharerGroupMember.firstname),
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    backgroundColor: const Color(0xff1C4668),
                    deleteIconColor: canDelete ? Colors.white : null,
                    onDeleted: canDelete ? () => onDeleted?.call(sharerGroupMember) : null,
                  ),
            ))
            .toList());
  }
}

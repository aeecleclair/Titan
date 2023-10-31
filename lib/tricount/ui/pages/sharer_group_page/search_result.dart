import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tricount/providers/sharer_group_member_list_provider.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  const SearchResult({super.key, required this.queryController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final sharerGroupMemberList = ref.watch(sharerGroupMemberListProvider);
    final sharerGroupMemberListNotifier =
        ref.watch(sharerGroupMemberListProvider.notifier);
    return AsyncChild(
        value: users,
        builder: (context, user) => Column(
            children: user
                .map((simpleUser) => GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 20),
                            Expanded(
                              child: Text(
                                simpleUser.getName(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]),
                    ),
                    onTap: () {
                      if (sharerGroupMemberList.map((e) => e.id).contains(simpleUser.id)) {
                        sharerGroupMemberListNotifier.removeMember(simpleUser);
                      }
                    }))
                .toList()));
  }
}

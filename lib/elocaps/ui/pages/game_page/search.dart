import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/user/providers/user_provider.dart';

class SearchResult extends HookConsumerWidget {
  final ValueNotifier<SimpleUser> user;
  final TextEditingController queryController;
  const SearchResult(
      {super.key, required this.user, required this.queryController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final me = ref.watch(userProvider);
    return AsyncChild(
        value: users,
        builder: (context, u) => Column(
            children: u
                .map((e) => GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                e.getName(),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: (user.value.id == e.id)
                                      ? FontWeight.bold
                                      : FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]),
                    ),
                    onTap: () {
                      user.value = e;
                      queryController.text = e.getName();
                      usersNotifier.clear();
                    }))
                .toList()));
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  const SearchResult({super.key, required this.queryController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final memberNotifier = ref.watch(completeMemberProvider.notifier);

    return users.when(
        data: (usersData) {
          return Column(
              children: usersData
                  .map((user) => GestureDetector(
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
                                  user.getName(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                      ),
                      onTap: () {
                        memberNotifier.setMember(Member.fromUser(user));
                        queryController.text = user.getName();
                        usersNotifier.clear();
                      }))
                  .toList());
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Text(e.toString()));
  }
}

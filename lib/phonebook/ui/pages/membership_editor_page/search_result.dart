import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  const SearchResult(
      {super.key, required this.queryController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final memberNotifier = ref.watch(completeMemberProvider.notifier);
    final member = ref.watch(completeMemberProvider);

    return users.when(
        data: (u) {
          return Column(
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
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                      ),
                      onTap: () {
                        debugPrint(e.toString());
                        debugPrint(Member.fromUser(e).toString());
                        memberNotifier.setMember(Member.fromUser(e));
                        debugPrint(member.toString());
                        queryController.text = e.getName();
                        usersNotifier.clear();
                      }))
                  .toList());
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Text(e.toString()));
  }
}

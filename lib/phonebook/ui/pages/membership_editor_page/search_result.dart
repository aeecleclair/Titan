import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/member.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/user/providers/user_list_provider.dart';

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
              .map(
                (user) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            offset: const Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 20),
                            Expanded(
                              child: Text(
                                user.getName(),
                                style: const TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    memberNotifier.setMember(Member.fromUser(user));
                    queryController.text = user.getName();
                    usersNotifier.clear();
                    memberNotifier.loadMemberComplete();
                  },
                ),
              )
              .toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Text(e.toString()),
    );
  }
}

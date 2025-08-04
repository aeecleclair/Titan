import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/member.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';
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
                (user) => ListItemTemplate(
                  title: user.getName(),
                  onTap: () {
                    memberNotifier.setMember(Member.fromUser(user));
                    queryController.text = user.getName();
                    usersNotifier.clear();
                    memberNotifier.loadMemberComplete();
                    Navigator.of(context).pop();
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

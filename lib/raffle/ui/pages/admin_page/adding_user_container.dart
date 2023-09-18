import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/ui/pages/admin_page/adding_user_card.dart';
import 'package:myecl/tools/ui/async_child.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddingUserContainer extends HookConsumerWidget {
  final VoidCallback onAdd;
  const AddingUserContainer({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    return AsyncChild(
        value: users,
        builder: (context, users) => Row(
              children: users
                  .map((e) => AddingUserCard(user: e, onAdd: onAdd))
                  .toList(),
            ));
  }
}

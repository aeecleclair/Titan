import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/ui/pages/admin_page/adding_user_card.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddingUserContainer extends HookConsumerWidget {
  final VoidCallback onAdd;
  const AddingUserContainer({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    return Row(
        children: users.when(
      data: (users) {
        return users.map((e) => AddingUserCard(user: e, onAdd: onAdd)).toList();
      },
      error: (error, stack) => [const Text('Error')],
      loading: () => [const Text('Loading')],
    ));
  }
}

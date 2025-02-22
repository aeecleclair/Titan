import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/meme/providers/ban_user_list_provider.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class UserAdminTab extends ConsumerWidget {
  const UserAdminTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannedUsers = ref.watch(bannedUsersProvider);
    final banNotifier = ref.watch(bannedUsersProvider.notifier);
    return AsyncChild(
      value: bannedUsers,
      builder: (context, bannedUsers) {
        return Column(
          children: bannedUsers.map((user) {
            return ListTile(
              title: Text(
                user.nickname != null
                    ? user.nickname! + ("${user.name} ${user.firstname}")
                    : "${user.name} ${user.firstname}",
              ),
              trailing: IconButton(
                icon: Icon(Icons.lock_open_outlined, color: Colors.green),
                onPressed: () => banNotifier.unbanUser(user.id),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

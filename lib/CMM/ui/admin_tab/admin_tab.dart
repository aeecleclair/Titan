import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/providers/cmm_ban_provider.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class AdminTab extends ConsumerWidget {
  const AdminTab({super.key});

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
              title: Text(user.name),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => banNotifier.unbanUser(user.id),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

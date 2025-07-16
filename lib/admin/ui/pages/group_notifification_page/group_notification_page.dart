import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';

class GroupNotificationPage extends HookConsumerWidget {
  const GroupNotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminTemplate(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notification de groupe",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}

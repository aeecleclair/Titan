import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/cash.dart';
import 'package:titan/amap/providers/cash_list_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/user/class/simple_users.dart';

class AddingUserCard extends HookConsumerWidget {
  final SimpleUser user;
  final VoidCallback onAdd;
  const AddingUserCard({super.key, required this.user, required this.onAdd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashNotifier = ref.watch(cashListProvider.notifier);
    return GestureDetector(
      onTap: () {
        cashNotifier.addCash(Cash(balance: 0, user: user));
        onAdd();
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 140,
          height: 75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  user.nickname ?? user.firstname,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AMAPColorConstants.textLight,
                  ),
                ),
                const SizedBox(height: 2),
                AutoSizeText(
                  user.nickname != null
                      ? '${user.firstname} ${user.name}'
                      : user.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AMAPColorConstants.textDark,
                  ),
                ),
                const SizedBox(height: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

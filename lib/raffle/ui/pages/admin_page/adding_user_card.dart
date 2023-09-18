import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/class/cash.dart';
import 'package:myecl/raffle/providers/cash_provider.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/user/class/list_users.dart';

class AddingUserCard extends HookConsumerWidget {
  final SimpleUser user;
  final VoidCallback onAdd;
  const AddingUserCard({super.key, required this.user, required this.onAdd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashNotifier = ref.watch(cashProvider.notifier);
    return GestureDetector(
      onTap: () {
        cashNotifier.addCash(Cash(
          balance: 0,
          user: user,
        ));
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
                          user.nickname != null
                              ? user.nickname!
                              : user.firstname,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: RaffleColorConstants.gradient2)),
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
                              color: RaffleColorConstants.textDark)),
                      const SizedBox(height: 3),
                    ],
                  )))),
    );
  }
}

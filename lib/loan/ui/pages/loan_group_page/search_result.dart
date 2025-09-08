import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/providers/borrower_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  const SearchResult({super.key, required this.queryController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final borrower = ref.watch(borrowerProvider);
    final borrowerNotifier = ref.watch(borrowerProvider.notifier);
    return AsyncChild(
      value: users,
      builder: (context, user) => Column(
        children: user
            .map(
              (simpleUser) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 20),
                      Expanded(
                        child: Text(
                          simpleUser.getName(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: (borrower.id == simpleUser.id)
                                ? FontWeight.bold
                                : FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  borrowerNotifier.setBorrower(simpleUser);
                  queryController.text = simpleUser.getName();
                  usersNotifier.clear();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

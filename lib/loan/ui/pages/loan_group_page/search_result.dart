import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/borrower_provider.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  const SearchResult(
      {super.key, required this.queryController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final borrower = ref.watch(borrowerProvider);
    final borrowerNotifier = ref.watch(borrowerProvider.notifier);
    return users.when(
        data: (u) {
          return Column(
              children: u
                  .map((e) => GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  e.getName(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: (borrower.id == e.id)
                                        ? FontWeight.bold
                                        : FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                      ),
                      onTap: () {
                        borrowerNotifier.setBorrower(e);
                        queryController.text = e.getName();
                        usersNotifier.clear();
                      }))
                  .toList());
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Text(e.toString()));
  }
}

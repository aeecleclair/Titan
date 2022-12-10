import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final ValueNotifier<SimpleUser> borrower;
  final TextEditingController queryController;
  final ValueNotifier<bool> displayUserSearch, focus;
  const SearchResult(
      {super.key,
      required this.borrower,
      required this.queryController,
      required this.displayUserSearch,
      required this.focus});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
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
                                    fontWeight: (borrower.value.id == e.id)
                                        ? FontWeight.bold
                                        : FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                      ),
                      onTap: () {
                        borrower.value = e;
                        queryController.text = e.getName();
                        displayUserSearch.value = false;
                        focus.value = false;
                      }))
                  .toList());
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Text(e.toString()));
  }
}

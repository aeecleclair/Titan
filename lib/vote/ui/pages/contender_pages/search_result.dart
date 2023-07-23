import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/loader.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/vote/providers/display_results.dart';

class SearchResult extends HookConsumerWidget {
  final ValueNotifier<SimpleUser> borrower;
  final TextEditingController queryController;
  const SearchResult(
      {super.key, required this.borrower, required this.queryController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final show = ref.watch(displayResult);
    final showNotifier = ref.watch(displayResult.notifier);
    return show
        ? users.when(
            data: (u) {
              return Column(
                  children: u
                      .map((e) => GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            showNotifier.setId(false);
                          }))
                      .toList());
            },
            loading: () => const Loader(),
            error: (e, s) => Text(e.toString()))
        : const SizedBox();
  }
}

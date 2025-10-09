import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:titan/vote/providers/display_results.dart';

class SearchResult extends HookConsumerWidget {
  final ValueNotifier<SimpleUser> borrower;
  final TextEditingController queryController;
  const SearchResult({
    super.key,
    required this.borrower,
    required this.queryController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final show = ref.watch(displayResult);
    final showNotifier = ref.watch(displayResult.notifier);
    return show
        ? AsyncChild(
            value: users,
            builder: (context, u) => Column(
              children: u
                  .map(
                    (e) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 20),
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
                          ],
                        ),
                      ),
                      onTap: () {
                        borrower.value = e;
                        queryController.text = e.getName();
                        showNotifier.setId(false);
                      },
                    ),
                  )
                  .toList(),
            ),
          )
        : const SizedBox();
  }
}

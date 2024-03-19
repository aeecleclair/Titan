import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/providers/players_provider.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  final int index;
  const SearchResult({
    super.key,
    required this.index,
    required this.queryController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final playersNotifier = ref.watch(playersProvider.notifier);
    final players = ref.watch(playersProvider);
    return AsyncChild(
      value: users,
      builder: (context, u) => Column(
        children: u
            .where((user) => !players.values.map((e) => e.id).contains(user.id))
            .map(
              (user) => GestureDetector(
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
                          user.getName(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  playersNotifier.setPlayer(index, user);
                  queryController.text = user.getName();
                  usersNotifier.clear();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

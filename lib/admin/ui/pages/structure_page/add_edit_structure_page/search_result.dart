import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/structure_manager_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  final TextEditingController queryController;
  const SearchResult({super.key, required this.queryController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final usersNotifier = ref.watch(userList.notifier);
    final structureManagerNotifier = ref.watch(
      structureManagerProvider.notifier,
    );

    return AsyncChild(
      value: users,
      builder: (context, usersData) {
        return Column(
          children: usersData
              .map(
                (user) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          user.getName(),
                          style: const TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          structureManagerNotifier.setUser(user);
                          usersNotifier.clear();
                          Navigator.of(context).pop();
                        },
                        child: const HeroIcon(HeroIcons.plus),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

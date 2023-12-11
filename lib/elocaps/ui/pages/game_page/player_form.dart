import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/elocaps/ui/pages/game_page/search.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class PlayerForm extends HookConsumerWidget {
  const PlayerForm(
      {Key? key,
      required this.index,
      required this.isFocused,
      required this.queryController,
      required this.user})
      : super(key: key);

  final int index;
  final ValueNotifier<List<bool>> isFocused;
  final TextEditingController queryController;
  final ValueNotifier<SimpleUser> user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          TextEntry(
            label: "Joueur ${index + 1}",
            onChanged: (value) {
              if (!isFocused.value[index]) {
                isFocused.value = List.generate(4, (index) => false)
                  ..[index] = true;
              }
              tokenExpireWrapper(ref, () async {
                if (queryController.text.isNotEmpty) {
                  await usersNotifier.filterUsers(queryController.text);
                } else {
                  usersNotifier.clear();
                }
              });
            },
            controller: queryController,
          ),
          const SizedBox(
            height: 10,
          ),
          if (isFocused.value[index])
            SearchResult(user: user, queryController: queryController)
        ],
      ),
    );
  }
}

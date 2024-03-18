import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/providers/is_field_focus_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/elocaps/ui/pages/game_page/search.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/elocaps/tools/constants.dart';

class PlayerForm extends HookConsumerWidget {
  const PlayerForm({
    super.key,
    required this.index,
    required this.queryController,
    required this.enable,
  });

  final int index;
  final TextEditingController queryController;
  final bool enable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);
    final isFocused = ref.watch(isFieldFocusProvider);
    final isFocusedNotifier = ref.watch(isFieldFocusProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          TextEntry(
            enabled: enable,
            label: "${ElocapsTextConstant.player} ${index + 1}",
            onChanged: (value) {
              if (index != isFocused) {
                isFocusedNotifier.setFocus(index);
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
          if (index == isFocused)
            SearchResult(index: index, queryController: queryController)
        ],
      ),
    );
  }
}

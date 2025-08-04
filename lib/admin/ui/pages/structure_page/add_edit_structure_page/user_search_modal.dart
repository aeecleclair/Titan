import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/ui/pages/structure_page/add_edit_structure_page/search_result.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class UserSearchModal extends HookConsumerWidget {
  const UserSearchModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);
    final textController = useTextEditingController();

    return BottomModalTemplate(
      title: "Choisir un gestionnaire",
      type: BottomModalType.main,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280),
            child: SingleChildScrollView(
              child: SearchResult(queryController: textController),
            ),
          ),
          CustomSearchBar(
            autofocus: true,
            onSearch: (value) => tokenExpireWrapper(ref, () async {
              if (value.isNotEmpty) {
                await usersNotifier.filterUsers(value);
                textController.text = value;
              } else {
                usersNotifier.clear();
                textController.clear();
              }
            }),
          ),
        ],
      ),
    );
  }
}

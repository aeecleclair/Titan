import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/providers/structure_manager_provider.dart';
import 'package:titan/admin/ui/pages/add_edit_structure_page/results.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:titan/l10n/app_localizations.dart';

class SearchUser extends HookConsumerWidget {
  const SearchUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);
    final structureManager = ref.watch(structureManagerProvider);

    return Column(
      children: [
        StyledSearchBar(
          label: AppLocalizations.of(context)!.adminManager,
          padding: const EdgeInsets.all(0),
          editingController: useTextEditingController(
            text: structureManager.id == SimpleUser.empty().id
                ? ""
                : structureManager.getName(),
          ),
          onChanged: (value) async {
            if (value.isNotEmpty) {
              await usersNotifier.filterUsers(value);
            } else {
              usersNotifier.clear();
            }
          },
          suffixIcon: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              padding: const EdgeInsets.all(7),
              child: HeroIcon(HeroIcons.plus, size: 20, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const MemberResults(),
      ],
    );
  }
}

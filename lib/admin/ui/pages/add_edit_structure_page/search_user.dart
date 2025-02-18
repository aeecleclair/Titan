import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/pages/add_edit_structure_page/results.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/styled_search_bar.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class SearchUser extends HookConsumerWidget {
  const SearchUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);

    return Column(
      children: [
        StyledSearchBar(
          label: AdminTextConstants.members,
          color: ColorConstants.gradient1,
          padding: const EdgeInsets.all(0),
          onChanged: (value) async {
            if (value.isNotEmpty) {
              await usersNotifier.filterUsers(
                value,
              );
            } else {
              usersNotifier.clear();
            }
          },
          suffixIcon: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ColorConstants.gradient1,
                    ColorConstants.gradient2,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.gradient2.withValues(alpha: 0.4),
                    offset: const Offset(2, 3),
                    blurRadius: 5,
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: HeroIcon(
                HeroIcons.plus,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const MemberResults(),
      ],
    );
  }
}

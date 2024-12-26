import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/admin_page/adding_user_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/tools/providers/theme_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

class AddingUserContainer extends HookConsumerWidget {
  final VoidCallback onAdd;
  const AddingUserContainer({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final isDarkTheme = ref.watch(themeProvider);
    return AsyncChild(
      value: users,
      builder: (context, users) => Row(
        children:
            users.map((e) => AddingUserCard(user: e, onAdd: onAdd)).toList(),
      ),
      loaderColor: AMAPColors(isDarkTheme).greenGradientSecondary,
    );
  }
}

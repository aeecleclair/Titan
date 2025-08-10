import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/providers/group_from_simple_group_provider.dart';
import 'package:titan/admin/providers/group_id_provider.dart';
import 'package:titan/admin/providers/group_provider.dart';
import 'package:titan/admin/ui/pages/groups/edit_group_page/search_user.dart';
import 'package:titan/tools/ui/builders/single_auto_loader_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

class EditGroupPage extends ConsumerWidget {
  const EditGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupId = ref.watch(groupIdProvider);
    final group = ref.watch(
      groupFromSimpleGroupProvider.select((map) => map[groupId]),
    );
    final groupNotifier = ref.watch(groupProvider.notifier);
    final groupFromSimpleGroupNotifier = ref.watch(
      groupFromSimpleGroupProvider.notifier,
    );
    return AdminTemplate(
      child: Refresher(
        onRefresh: () async {
          await groupNotifier.loadGroup(groupId);
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SingleAutoLoaderChild(
              item: group,
              notifier: groupFromSimpleGroupNotifier,
              mapKey: groupId,
              loader: groupNotifier.loadGroup,
              dataBuilder: (BuildContext context, value) {
                return SearchUser();
              },
            ),
          ),
        ),
      ),
    );
  }
}

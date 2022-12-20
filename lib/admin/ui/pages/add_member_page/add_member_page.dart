import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/pages/add_member_page/results.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddMemberPage extends HookConsumerWidget {
  const AddMemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);
    final editingController = useTextEditingController();
    final group = ref.watch(groupProvider);
    return Refresher(
      onRefresh: () async {
        usersNotifier.clear();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            SizedBox(
              child: Column(children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AdminTextConstants.addingMember,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gradient1)),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  onChanged: (value) {
                    tokenExpireWrapper(ref, () async {
                      if (editingController.text.isNotEmpty) {
                        await usersNotifier.filterUsers(editingController.text,
                            excludeGroup: [group.value!.toSimpleGroup()]);
                      } else {
                        usersNotifier.clear();
                      }
                    });
                  },
                  controller: editingController,
                  cursorColor: ColorConstants.gradient1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.tertiary)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFfb6d10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const MemberResults()
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

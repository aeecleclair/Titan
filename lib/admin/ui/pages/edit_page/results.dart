import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/providers/simple_groups_groups_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class MemberResults extends HookConsumerWidget {
  const MemberResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupProvider);
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final users = ref.watch(userList);
    final simplegroupGroupsNotifier =
        ref.watch(simpleGroupsGroupsProvider.notifier);
    return users.when(
        data: (value) {
          return Column(
            children: value
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              e.getName(),
                              style: const TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    if (!group.value!.members.contains(e)) {
                                      Group newGroup = group.value!.copyWith(
                                          members: group.value!.members + [e]);
                                      tokenExpireWrapper(ref, () async {
                                        groupNotifier
                                            .addMember(newGroup, e)
                                            .then((value) {
                                          if (value) {
                                            simplegroupGroupsNotifier
                                                .setTData(newGroup.id,
                                                    AsyncData([newGroup]))
                                                .then((value) {
                                              pageNotifier
                                                  .setAdminPage(AdminPage.edit);
                                              displayToast(
                                                  context,
                                                  TypeMsg.msg,
                                                  AdminTextConstants
                                                      .addedMember);
                                            });
                                          } else {
                                            displayToast(context, TypeMsg.error,
                                                AdminTextConstants.addingError);
                                          }
                                        });
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.add))
                            ],
                          ),
                        ],
                      ),
                    ))
                .toList(),
          );
        },
        loading: () => const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.gradient1,
              ),
            ),
        error: (error, stack) => Center(
              child: Text(error.toString()),
            ));
  }
}

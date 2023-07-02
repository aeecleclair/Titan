import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/simple_groups_groups_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class MemberResults extends HookConsumerWidget {
  const MemberResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final users = ref.watch(userList);
    final simpleGroupGroupsNotifier =
        ref.watch(simpleGroupsGroupsProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

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
                              ShrinkButton(
                                  onTap: () async {
                                    if (!group.value!.members.contains(e)) {
                                      Group newGroup = group.value!.copyWith(
                                          members: group.value!.members + [e]);
                                      await tokenExpireWrapper(ref, () async {
                                        groupNotifier
                                            .addMember(newGroup, e)
                                            .then((value) {
                                          if (value) {
                                            simpleGroupGroupsNotifier
                                                .setTData(newGroup.id,
                                                    AsyncData([newGroup]))
                                                .then((value) {
                                              displayToastWithContext(
                                                  TypeMsg.msg,
                                                  AdminTextConstants
                                                      .addedMember);
                                            });
                                          } else {
                                            displayToastWithContext(
                                                TypeMsg.error,
                                                AdminTextConstants.addingError);
                                          }
                                        });
                                      });
                                    }
                                  },
                                  waitChild: const Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: ColorConstants.gradient1,
                                      ),
                                    ),
                                  ),
                                  child: const HeroIcon(HeroIcons.plus))
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

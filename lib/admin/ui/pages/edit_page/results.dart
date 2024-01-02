import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/simple_groups_groups_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/tools/functions.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class MemberResults extends HookConsumerWidget {
  const MemberResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final users = ref.watch(userList);
    final simpleGroupsGroupsNotifier =
        ref.watch(simpleGroupsGroupsProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AsyncChild(
        value: users,
        builder: (context, value) => Column(
              children: value
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                getName(e),
                                style: const TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                WaitingButton(
                                    onTap: () async {
                                      if (!group.value!.members!.contains(e)) {
                                        CoreGroup newGroup = group.value!
                                            .copyWith(
                                                members: group.value!.members! +
                                                    [e]);
                                        await tokenExpireWrapper(ref, () async {
                                          groupNotifier
                                              .addMember(newGroup, e)
                                              .then((value) {
                                            if (value) {
                                              simpleGroupsGroupsNotifier
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
                                                  AdminTextConstants
                                                      .addingError);
                                            }
                                          });
                                        });
                                      }
                                    },
                                    waitingColor: ColorConstants.gradient1,
                                    builder: (child) => child,
                                    child: const HeroIcon(HeroIcons.plus))
                              ],
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
        loaderColor: ColorConstants.gradient1);
  }
}

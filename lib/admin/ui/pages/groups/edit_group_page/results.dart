import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/group.dart';
import 'package:titan/admin/providers/group_provider.dart';
import 'package:titan/admin/providers/simple_groups_groups_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class MemberResults extends HookConsumerWidget {
  const MemberResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final users = ref.watch(userList);
    final simpleGroupGroupsNotifier = ref.watch(
      simpleGroupsGroupsProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AsyncChild(
      value: users,
      builder: (context, value) => Column(
        children: value
            .map(
              (e) => Padding(
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
                        WaitingButton(
                          onTap: () async {
                            if (!group.value!.members.contains(e)) {
                              Group newGroup = group.value!.copyWith(
                                members: group.value!.members + [e],
                              );
                              await tokenExpireWrapper(ref, () async {
                                groupNotifier.addMember(newGroup, e).then((
                                  value,
                                ) {
                                  if (value) {
                                    simpleGroupGroupsNotifier.setTData(
                                      newGroup.id,
                                      AsyncData([newGroup]),
                                    );
                                    displayToastWithContext(
                                      TypeMsg.msg,
                                      AdminTextConstants.addedMember,
                                    );
                                  } else {
                                    displayToastWithContext(
                                      TypeMsg.error,
                                      AdminTextConstants.addingError,
                                    );
                                  }
                                });
                              });
                            }
                          },
                          waitingColor: ColorConstants.gradient1,
                          builder: (child) => child,
                          child: const HeroIcon(HeroIcons.plus),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
      loaderColor: ColorConstants.gradient1,
    );
  }
}

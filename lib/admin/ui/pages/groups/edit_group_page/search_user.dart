import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/group.dart';
import 'package:titan/admin/providers/group_id_provider.dart';
import 'package:titan/admin/providers/group_provider.dart';
import 'package:titan/admin/providers/simple_groups_groups_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/ui/pages/groups/edit_group_page/results.dart';
import 'package:titan/admin/ui/components/user_ui.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/loader.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class SearchUser extends HookConsumerWidget {
  const SearchUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupProvider);
    final usersNotifier = ref.watch(userList.notifier);
    final groupId = ref.watch(groupIdProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final simpleGroupsGroups = ref.watch(simpleGroupsGroupsProvider);
    final simpleGroupGroupsNotifier = ref.watch(
      simpleGroupsGroupsProvider.notifier,
    );
    final add = useState(false);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final simpleGroup = simpleGroupsGroups[groupId];
    if (simpleGroup == null) {
      return const Loader();
    }
    return AsyncChild(
      value: simpleGroup,
      builder: (context, g) {
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
                    excludeGroup: [group.value!.toSimpleGroup()],
                  );
                } else {
                  usersNotifier.clear();
                }
              },
              onSuffixIconTap: (focusNode, editingController) {
                add.value = !add.value;
                if (!add.value) {
                  editingController.clear();
                  usersNotifier.clear();
                  focusNode.unfocus();
                } else {
                  focusNode.requestFocus();
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
                    !add.value ? HeroIcons.plus : HeroIcons.xMark,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (add.value) const SizedBox(height: 10),
            if (add.value) const MemberResults(),
            if (!add.value)
              ...g[0].members.map(
                (x) => UserUi(
                  user: x,
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialogBox(
                        descriptions: AdminTextConstants.removeGroupMember,
                        title: AdminTextConstants.deleting,
                        onYes: () async {
                          await tokenExpireWrapper(ref, () async {
                            Group newGroup = g[0].copyWith(
                              members: g[0].members
                                  .where((element) => element.id != x.id)
                                  .toList(),
                            );
                            final value = await groupNotifier.deleteMember(
                              newGroup,
                              x,
                            );
                            if (value) {
                              simpleGroupGroupsNotifier.setTData(
                                newGroup.id,
                                AsyncData([newGroup]),
                              );
                              displayToastWithContext(
                                TypeMsg.msg,
                                AdminTextConstants.updatedGroup,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.msg,
                                AdminTextConstants.updatingError,
                              );
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

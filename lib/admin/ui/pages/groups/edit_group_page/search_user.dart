import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/group.dart';
import 'package:titan/admin/providers/group_from_simple_group_provider.dart';
import 'package:titan/admin/providers/group_id_provider.dart';
import 'package:titan/admin/providers/group_provider.dart';
import 'package:titan/admin/ui/components/user_ui.dart';
import 'package:titan/admin/ui/pages/groups/edit_group_page/results.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:titan/l10n/app_localizations.dart';

class SearchUser extends HookConsumerWidget {
  const SearchUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);
    final groupId = ref.watch(groupIdProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final groupMap = ref.watch(groupFromSimpleGroupProvider);
    final group = groupMap[groupId];
    final groupFromSimpleGroupNotifier = ref.watch(
      groupFromSimpleGroupProvider.notifier,
    );

    final add = useState(false);
    final searchFocusNode = useFocusNode();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    if (group == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return AsyncChild(
      value: group,
      builder: (context, g) {
        return Column(
          children: [
            CustomSearchBar(
              focusNode: searchFocusNode,
              onSearch: (value) async {
                if (value.isNotEmpty) {
                  add.value
                      ? await usersNotifier.filterUsers(value, excludeGroup: [])
                      : await usersNotifier.filterUsers(
                          value,
                          excludeGroup: [],
                        );
                } else {
                  usersNotifier.clear();
                }
              },
            ),
            const SizedBox(height: 10),
            Button(
              text: !add.value ? 'Ajouter' : "Terminer",
              onPressed: () {
                add.value = !add.value;
                if (add.value) {
                  searchFocusNode.requestFocus();
                } else {
                  searchFocusNode.unfocus();
                }
              },
            ),
            if (add.value) const SizedBox(height: 10),
            if (add.value) const MemberResults(),
            if (!add.value)
              ...g.members.map(
                (x) => UserUi(
                  user: x,
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialogBox(
                        descriptions: AppLocalizations.of(
                          context,
                        )!.adminRemoveGroupMember,
                        title: AppLocalizations.of(context)!.adminDeleting,
                        onYes: () async {
                          final updatedGroupMsg = AppLocalizations.of(
                            context,
                          )!.adminUpdatedGroup;
                          final updatingErrorMsg = AppLocalizations.of(
                            context,
                          )!.adminUpdatingError;
                          await tokenExpireWrapper(ref, () async {
                            Group newGroup = g.copyWith(
                              members: g.members
                                  .where((element) => element.id != x.id)
                                  .toList(),
                            );
                            final value = await groupNotifier.deleteMember(
                              newGroup,
                              x,
                            );
                            if (value) {
                              groupFromSimpleGroupNotifier.setTData(
                                newGroup.id,
                                AsyncData(newGroup),
                              );
                              displayToastWithContext(
                                TypeMsg.msg,
                                updatedGroupMsg,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.msg,
                                updatingErrorMsg,
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

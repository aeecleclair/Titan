import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/group.dart';
import 'package:titan/admin/providers/group_from_simple_group_provider.dart';
import 'package:titan/admin/providers/group_provider.dart';
import 'package:titan/admin/ui/components/user_ui.dart';
import 'package:titan/admin/ui/pages/groups/edit_group_page/results.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
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
    final groupNotifier = ref.watch(groupProvider.notifier);
    final group = ref.watch(groupProvider);
    final groupFromSimpleGroupNotifier = ref.watch(
      groupFromSimpleGroupProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final localizeWithContext = AppLocalizations.of(context)!;

    return AsyncChild(
      value: group,
      builder: (context, g) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    onSearch: (value) async {
                      if (value.isNotEmpty) {
                        await usersNotifier.filterUsers(
                          value,
                          includeGroup: [g.toSimpleGroup()],
                        );
                      } else {
                        usersNotifier.clear();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                CustomIconButton(
                  icon: HeroIcon(HeroIcons.plus, size: 30, color: Colors.white),
                  onPressed: () async {
                    await showCustomBottomModal(
                      context: context,
                      ref: ref,
                      modal: BottomModalTemplate(
                        title: localizeWithContext.adminAddMember,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 300),
                          child: Column(
                            children: [
                              CustomSearchBar(
                                onSearch: (value) async {
                                  if (value.isNotEmpty) {
                                    await usersNotifier.filterUsers(
                                      value,
                                      excludeGroup: [g.toSimpleGroup()],
                                    );
                                  } else {
                                    usersNotifier.clear();
                                  }
                                },
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: const MemberResults(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
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

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/simple_groups_groups_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/pages/edit_page/results.dart';
import 'package:myecl/admin/ui/components/user_ui.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class SearchUser extends HookConsumerWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingController = useTextEditingController();
    final group = ref.watch(groupProvider);
    final usersNotifier = ref.watch(userList.notifier);
    final groupId = ref.watch(groupIdProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final simplegroupsGroups = ref.watch(simpleGroupsGroupsProvider);
    final simplegroupGroupsNotifier =
        ref.watch(simpleGroupsGroupsProvider.notifier);
    final add = useState(false);
    final focusNode = useFocusNode();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return simplegroupsGroups.when(data: (value) {
      final g = value[groupId];
      if (g == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return g.when(
        data: (g) {
          return Column(
            children: [
              TextField(
                focusNode: focusNode,
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
                decoration: InputDecoration(
                    labelText: AdminTextConstants.members,
                    labelStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.background2),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        add.value = !add.value;
                        if (!add.value) {
                          editingController.clear();
                          usersNotifier.clear();
                          focusNode.unfocus();
                        } else {
                          focusNode.requestFocus();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  ColorConstants.gradient1,
                                  ColorConstants.gradient2
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      ColorConstants.gradient2.withOpacity(0.4),
                                  offset: const Offset(2, 3),
                                  blurRadius: 5)
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: HeroIcon(
                            !add.value ? HeroIcons.plus : HeroIcons.xMark,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstants.gradient1,
                      ),
                    )),
              ),
              if (add.value) const SizedBox(height: 10),
              if (add.value) const MemberResults(),
              if (!add.value)
                ...g[0].members.map((x) => UserUi(
                    user: x,
                    onDelete: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialogBox(
                              descriptions:
                                  AdminTextConstants.removeAssociationMember,
                              title: AdminTextConstants.deleting,
                              onYes: () async {
                                await tokenExpireWrapper(ref, () async {
                                  Group newGroup = g[0].copyWith(
                                      members: g[0]
                                          .members
                                          .where(
                                              (element) => element.id != x.id)
                                          .toList());
                                  final value = await groupNotifier
                                      .deleteMember(newGroup, x);
                                  if (value) {
                                    simplegroupGroupsNotifier.setTData(
                                        newGroup.id, AsyncData([newGroup]));
                                    displayToastWithContext(TypeMsg.msg,
                                        AdminTextConstants.updatedAssociation);
                                  } else {
                                    displayToastWithContext(TypeMsg.msg,
                                        AdminTextConstants.updatingError);
                                  }
                                });
                              }));
                    })),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, s) => const Center(
          child: Text('Error'),
        ),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, error: (e, s) {
      return const Center(
        child: Text('Error'),
      );
    });
  }
}

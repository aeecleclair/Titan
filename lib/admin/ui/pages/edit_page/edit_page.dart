import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/simple_groups_groups_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/components/admin_button.dart';
import 'package:myecl/admin/ui/pages/edit_page/search_user.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/shrink_button.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EditAssociationPage extends HookConsumerWidget {
  const EditAssociationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupId = ref.watch(groupIdProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final groupListNotifier = ref.watch(allGroupListProvider.notifier);
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    final simpleGroupsGroupsNotifier =
        ref.watch(simpleGroupsGroupsProvider.notifier);
    final simpleGroupsGroups = ref.watch(simpleGroupsGroupsProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: AutoLoaderChild(
                    value: simpleGroupsGroups,
                    notifier: simpleGroupsGroupsNotifier,
                    mapKey: groupId,
                    loader: (groupId) async =>
                        (await groupNotifier.loadGroup(groupId)).maybeWhen(
                            data: (groups) => groups,
                            orElse: () => Group.empty()),
                    dataBuilder: (context, group) {
                      name.text = group.name;
                      description.text = group.description;
                      return Column(children: [
                        const AlignLeftText(AdminTextConstants.edit,
                            fontSize: 20, color: ColorConstants.gradient1),
                        const SizedBox(height: 20),
                        Form(
                          key: key,
                          child: Column(children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerLeft,
                              child: TextEntry(
                                controller: name,
                                color: ColorConstants.gradient1,
                                label: AdminTextConstants.name,
                                suffixIcon: const HeroIcon(HeroIcons.pencil),
                                enabledColor: Colors.transparent,
                              ),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: TextEntry(
                                  controller: description,
                                  color: ColorConstants.gradient1,
                                  label: AdminTextConstants.description,
                                  suffixIcon: const HeroIcon(HeroIcons.pencil),
                                  enabledColor: Colors.transparent,
                                )),
                            const SizedBox(height: 20),
                            ShrinkButton(
                              onTap: () async {
                                if (!key.currentState!.validate()) {
                                  return;
                                }
                                await tokenExpireWrapper(ref, () async {
                                  Group newGroup = group.copyWith(
                                      name: name.text,
                                      description: description.text);
                                  groupNotifier.setGroup(newGroup);
                                  final value = await groupListNotifier
                                      .updateGroup(newGroup.toSimpleGroup());
                                  if (value) {
                                    QR.back();
                                    displayToastWithContext(TypeMsg.msg,
                                        AdminTextConstants.updatedAssociation);
                                  } else {
                                    displayToastWithContext(TypeMsg.msg,
                                        AdminTextConstants.updatingError);
                                  }
                                });
                              },
                              builder: (child) => AdminButton(child: child),
                              child: const Text(
                                AdminTextConstants.edit,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const SearchUser(),
                          ]),
                        )
                      ]);
                    },
                    loaderColor: Colors.white))));
  }
}

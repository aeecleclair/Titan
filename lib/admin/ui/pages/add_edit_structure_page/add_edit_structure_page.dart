import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/association_membership_simple.dart';
import 'package:myecl/admin/providers/association_membership_list_provider.dart';
import 'package:myecl/admin/providers/structure_manager_provider.dart';
import 'package:myecl/admin/providers/structure_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/components/admin_button.dart';
import 'package:myecl/admin/ui/components/text_editing.dart';
import 'package:myecl/admin/ui/pages/add_edit_structure_page/search_user.dart';
import 'package:myecl/paiement/class/structure.dart';
import 'package:myecl/paiement/providers/structure_list_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/user/class/simple_users.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditStructurePage extends HookConsumerWidget {
  const AddEditStructurePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final structure = ref.watch(structureProvider);
    final structureManager = ref.watch(structureManagerProvider);
    final structureManagerNotifier = ref.watch(
      structureManagerProvider.notifier,
    );
    final structureListNotifier = ref.watch(structureListProvider.notifier);
    final isEdit = structure.id != '';
    final name = useTextEditingController(text: isEdit ? structure.name : null);
    final allAssociationMembershipList = ref.watch(
      allAssociationMembershipListProvider,
    );
    final currentMembership = useState<AssociationMembership>(
      (isEdit)
          ? structure.associationMembership
          : AssociationMembership.empty(),
    );
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Form(
            key: key,
            child: Column(
              children: [
                const SizedBox(height: 20),
                AlignLeftText(
                  isEdit
                      ? AdminTextConstants.editStructure
                      : AdminTextConstants.addStructure,
                ),
                const SizedBox(height: 20),
                TextEditing(controller: name, label: AdminTextConstants.name),
                AsyncChild(
                  value: allAssociationMembershipList,
                  builder: (context, allAssociationMembershipList) {
                    return HorizontalListView.builder(
                      height: 40,
                      items: [
                        ...allAssociationMembershipList,
                        AssociationMembership.empty(),
                      ],
                      itemBuilder: (context, associationMembership, index) {
                        final selected =
                            currentMembership.value.id ==
                            associationMembership.id;
                        return ItemChip(
                          selected: selected,
                          onTap: () async {
                            currentMembership.value = associationMembership;
                          },
                          child: Text(
                            associationMembership.name.toUpperCase(),
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                isEdit
                    ? Column(
                        children: [
                          Text(
                            AdminTextConstants.manager,
                            style: TextStyle(
                              color: ColorConstants.gradient1,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            structureManager.getName(),
                            style: TextStyle(
                              color: ColorConstants.gradient1,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SearchUser(),
                const SizedBox(height: 20),
                WaitingButton(
                  onTap: () async {
                    if (key.currentState == null) {
                      return;
                    }
                    if (structureManager.id.isEmpty && !isEdit) {
                      displayToastWithContext(
                        TypeMsg.error,
                        AdminTextConstants.noManager,
                      );
                      return;
                    }
                    if (key.currentState!.validate()) {
                      await tokenExpireWrapper(ref, () async {
                        final value = isEdit
                            ? await structureListNotifier.updateStructure(
                                Structure(
                                  name: name.text,
                                  associationMembership:
                                      currentMembership.value,
                                  managerUser: structureManager,
                                  id: structure.id,
                                ),
                              )
                            : await structureListNotifier.createStructure(
                                Structure(
                                  name: name.text,
                                  associationMembership:
                                      currentMembership.value,
                                  managerUser: structureManager,
                                  id: '',
                                ),
                              );
                        if (value) {
                          QR.back();
                          structureManagerNotifier.setUser(SimpleUser.empty());
                          displayToastWithContext(
                            TypeMsg.msg,
                            isEdit
                                ? AdminTextConstants.editedStructure
                                : AdminTextConstants.addedStructure,
                          );
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            AdminTextConstants.addingError,
                          );
                        }
                      });
                    }
                  },
                  builder: (child) => AdminButton(child: child),
                  child: Text(
                    isEdit ? AdminTextConstants.edit : AdminTextConstants.add,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

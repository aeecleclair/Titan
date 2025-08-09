import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/ui/pages/structure_page/add_edit_structure_page/user_search_modal.dart';
import 'package:titan/admin/class/association_membership_simple.dart';
import 'package:titan/admin/providers/association_membership_list_provider.dart';
import 'package:titan/admin/providers/structure_manager_provider.dart';
import 'package:titan/admin/providers/structure_provider.dart';
import 'package:titan/paiement/class/structure.dart';
import 'package:titan/paiement/providers/structure_list_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/vote/ui/pages/admin_page/admin_button.dart';

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

    final localizeWithContext = AppLocalizations.of(context)!;

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextEntry(
                    controller: name,
                    label: localizeWithContext.adminName,
                  ),
                ),
                const SizedBox(height: 20),
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
                (isEdit | (structureManager.id != ""))
                    ? Column(
                        children: [
                          Text(
                            localizeWithContext.adminManager,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            structureManager.getName(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : ListItem(
                        title: localizeWithContext.adminSelectManager,
                        onTap: () async {
                          await showCustomBottomModal(
                            context: context,
                            ref: ref,
                            modal: UserSearchModal(),
                          );
                        },
                      ),
                const SizedBox(height: 20),
                WaitingButton(
                  onTap: () async {
                    if (key.currentState == null) {
                      return;
                    }
                    if (structureManager.id.isEmpty && !isEdit) {
                      displayToastWithContext(
                        TypeMsg.error,
                        localizeWithContext.adminNoManager,
                      );
                      return;
                    }
                    if (key.currentState!.validate()) {
                      await tokenExpireWrapper(ref, () async {
                        final editedStructureMsg = isEdit
                            ? localizeWithContext.adminEditedStructure
                            : localizeWithContext.adminAddedStructure;
                        final addedStructureErrorMsg = AppLocalizations.of(
                          context,
                        )!.adminAddingError;
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
                            editedStructureMsg,
                          );
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            addedStructureErrorMsg,
                          );
                        }
                      });
                    }
                  },
                  builder: (child) => AdminButton(child: child),
                  child: Text(
                    isEdit
                        ? localizeWithContext.adminEdit
                        : localizeWithContext.adminAdd,
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

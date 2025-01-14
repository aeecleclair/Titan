import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/structure_manager_id_provider.dart';
import 'package:myecl/admin/providers/structure_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/components/admin_button.dart';
import 'package:myecl/admin/ui/components/text_editing.dart';
import 'package:myecl/admin/ui/pages/add_edit_structure_page/search_user.dart';
import 'package:myecl/paiement/class/structure.dart';
import 'package:myecl/paiement/providers/structure_list_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditStructurePage extends HookConsumerWidget {
  const AddEditStructurePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final structure = ref.watch(structureProvider);
    final structureManagerId = ref.watch(structureManagerIdProvider);
    final structureManagerIdNotifier =
        ref.watch(structureManagerIdProvider.notifier);
    final structureListNotifier = ref.watch(structureListProvider.notifier);
    final isEdit = structure.id != Structure.empty().id;
    final name = useTextEditingController(text: isEdit ? structure.name : null);
    final membership = useState<AvailableAssociationMembership>(
      isEdit ? structure.membership : AvailableAssociationMembership.AEECL,
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
                const AlignLeftText(AdminTextConstants.addStructure),
                const SizedBox(height: 30),
                TextEditing(controller: name, label: AdminTextConstants.name),
                HorizontalListView.builder(
                  height: 40,
                  items: AvailableAssociationMembership.values,
                  itemBuilder: (context, value, index) {
                    final selected = membership.value == value;
                    return ItemChip(
                      selected: selected,
                      onTap: () async {
                        membership.value = value;
                      },
                      child: Text(
                        value.name.toUpperCase(),
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                if (!isEdit) const SearchUser(),
                if (!isEdit) const SizedBox(height: 20),
                WaitingButton(
                  onTap: () async {
                    if (key.currentState == null) {
                      return;
                    }
                    if (key.currentState!.validate()) {
                      await tokenExpireWrapper(ref, () async {
                        final value =
                            await structureListNotifier.createStructure(
                          Structure(
                            name: name.text,
                            membership: membership.value,
                            managerUserId: structureManagerId,
                            id: '',
                          ),
                        );
                        if (value) {
                          QR.back();
                          structureManagerIdNotifier.setId('');
                          displayToastWithContext(
                            TypeMsg.msg,
                            AdminTextConstants.addedStructure,
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
                  child: const Text(
                    AdminTextConstants.add,
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

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/button.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class AssociationGroupementAddEditPage extends HookConsumerWidget {
  const AssociationGroupementAddEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationGroupement = ref.watch(associationGroupementProvider);
    final associaitonGroupementListNotifier = ref.watch(
      associationGroupementListProvider.notifier,
    );
    final groups = ref.watch(allGroupListProvider);
    final name = useTextEditingController(text: associationGroupement.name);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final selectedGroup = useState(associationGroupement.managerGroupId);

    return PhonebookTemplate(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                associationGroupement.id.isNotEmpty
                    ? PhonebookTextConstants.editAssociationGroupement
                    : PhonebookTextConstants.addAssociationGroupement,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.title,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextEntry(
              controller: name,
              label: AdminTextConstants.name,
              canBeEmpty: false,
            ),
            const SizedBox(height: 20),
            AsyncChild(
              value: groups,
              builder: (context, groupList) => SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final group = groupList[index];
                    return ItemChip(
                      selected: selectedGroup.value == group.id,
                      onTap: () {
                        if (selectedGroup.value != group.id) {
                          selectedGroup.value = group.id;
                        } else {
                          selectedGroup.value = "";
                        }
                      },
                      child: Text(
                        group.name,
                        style: TextStyle(
                          color: selectedGroup.value == group.id
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                  itemCount: groupList.length,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Button(
              text: AdminTextConstants.add,
              onPressed: () async {
                if (name.text.isEmpty) {
                  displayToastWithContext(
                    TypeMsg.error,
                    AdminTextConstants.emptyFieldError,
                  );
                  return;
                }
                if (selectedGroup.value.isEmpty) {
                  displayToastWithContext(
                    TypeMsg.error,
                    PhonebookTextConstants.emptyManagerGroupError,
                  );
                  return;
                }
                await tokenExpireWrapper(ref, () async {
                  if (associationGroupement.id.isNotEmpty) {
                    final value = await associaitonGroupementListNotifier
                        .updateAssociationGroupement(
                          AssociationGroupement(
                            id: associationGroupement.id,
                            name: name.text,
                            managerGroupId: selectedGroup.value,
                          ),
                        );
                    if (value) {
                      displayToastWithContext(
                        TypeMsg.msg,
                        PhonebookTextConstants.addedAssociation,
                      );
                      QR.back();
                    } else {
                      displayToastWithContext(
                        TypeMsg.error,
                        AdminTextConstants.updatingError,
                      );
                    }
                    return;
                  }
                  final value = await associaitonGroupementListNotifier
                      .createAssociationGroupement(
                        AssociationGroupement(
                          id: "",
                          name: name.text,
                          managerGroupId: selectedGroup.value,
                        ),
                      );
                  if (value) {
                    displayToastWithContext(
                      TypeMsg.msg,
                      PhonebookTextConstants.addedAssociation,
                    );
                    QR.back();
                  } else {
                    displayToastWithContext(
                      TypeMsg.error,
                      AdminTextConstants.addingError,
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

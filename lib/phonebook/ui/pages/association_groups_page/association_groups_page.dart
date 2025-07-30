import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/l10n/app_localizations.dart';

class AssociationGroupsPage extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  AssociationGroupsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final association = ref.watch(associationProvider);
    final associationListNotifier = ref.watch(associationListProvider.notifier);

    final groups = ref.watch(allGroupListProvider);
    List<SimpleGroup> selectedGroups = groups.maybeWhen(
      data: (value) {
        return value.where((element) {
          return association.associatedGroups.contains(element.id);
        }).toList();
      },
      orElse: () {
        return [];
      },
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhonebookTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: ExpansionTile(
                      title: Text(
                        AppLocalizations.of(context)!.phonebookGroups,
                      ),
                      children: groups.maybeWhen(
                        data: (data) {
                          return data.map((group) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    offset: const Offset(0, 1),
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      group.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      return Checkbox(
                                        value: selectedGroups.contains(group),
                                        onChanged: (value) {
                                          if (value == true) {
                                            selectedGroups.add(group);
                                          } else {
                                            selectedGroups.remove(group);
                                          }
                                          setState(() {});
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList();
                        },
                        orElse: () {
                          return [];
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            WaitingButton(
              builder: (child) => AddEditButtonLayout(
                colors: const [
                  ColorConstants.gradient1,
                  ColorConstants.gradient2,
                ],
                child: child,
              ),
              onTap: () async {
                await tokenExpireWrapper(ref, () async {
                  final updatedGroupsMsg = AppLocalizations.of(
                    context,
                  )!.phonebookUpdatedGroups;
                  final updatingErrorMsg = AppLocalizations.of(
                    context,
                  )!.phonebookUpdatingError;
                  final value = await associationListNotifier
                      .updateAssociationGroups(
                        association.copyWith(
                          associatedGroups: selectedGroups
                              .map((e) => e.id)
                              .toList(),
                        ),
                      );
                  if (value) {
                    displayToastWithContext(TypeMsg.msg, updatedGroupsMsg);
                  } else {
                    displayToastWithContext(TypeMsg.msg, updatingErrorMsg);
                  }
                });
              },
              child: Text(
                AppLocalizations.of(context)!.phonebookUpdateGroups,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

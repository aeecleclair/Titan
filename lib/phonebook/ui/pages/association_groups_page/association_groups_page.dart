import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item_toggle.dart';

class AssociationGroupsPage extends HookConsumerWidget {
  const AssociationGroupsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final association = ref.watch(associationProvider);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationGroupementNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );

    final groups = ref.watch(allGroupListProvider);

    AppLocalizations localizeWithContext = AppLocalizations.of(context)!;

    final selectedGroups = groups.maybeWhen(
      data: (value) {
        return useState<List<SimpleGroup>>(
          List.from(
            value.where((element) {
              return association.associatedGroups.contains(element.id);
            }).toList(),
          ),
        );
      },
      orElse: () {
        return useState<List<SimpleGroup>>([]);
      },
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhonebookTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await tokenExpireWrapper(ref, () async {
            await associationListNotifier.loadAssociations();
            await ref.read(allGroupListProvider.notifier).loadGroups();
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizeWithContext.phonebookGroups(association.name),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              AsyncChild(
                value: groups,
                builder: (context, groupList) {
                  return Column(
                    children: groupList
                        .map(
                          (group) => ToggleListItem(
                            title: group.name,
                            selected: selectedGroups.value.contains(group),
                            onTap: () {
                              final groups = [...selectedGroups.value];
                              if (groups.contains(group)) {
                                groups.remove(group);
                              } else {
                                groups.add(group);
                              }
                              selectedGroups.value = groups;
                            },
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 20),
              Button(
                onPressed: () async {
                  await tokenExpireWrapper(ref, () async {
                    final value = await associationListNotifier
                        .updateAssociationGroups(
                          association.copyWith(
                            associatedGroups: selectedGroups.value
                                .map((e) => e.id)
                                .toList(),
                          ),
                        );
                    if (value) {
                      displayToastWithContext(
                        TypeMsg.msg,
                        localizeWithContext.phonebookUpdatedGroups,
                      );
                      associationGroupementNotifier
                          .resetAssociationGroupement();
                      QR.back();
                    } else {
                      displayToastWithContext(
                        TypeMsg.msg,
                        localizeWithContext.phonebookUpdatingError,
                      );
                    }
                  });
                },
                text: localizeWithContext.phonebookUpdateGroups,
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

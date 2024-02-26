import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/providers/research_filter_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/radio_chip.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/association_research_bar.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/editable_association_card.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationsNotifier = ref.watch(associationListProvider.notifier);
    final associations = ref.watch(associationListProvider);
    final roleNotifier = ref.watch(rolesTagsProvider.notifier);
    final associationKinds = ref.watch(associationKindsProvider);
    final kind = useState('');
    final kindNotifier = ref.watch(associationKindProvider.notifier);
    final nameFilter = ref.watch(filterProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Refresher(
        onRefresh: () async {
          await associationsNotifier.loadAssociations();
          await roleNotifier.loadRolesTags();
        },
        child: Column(children: <Widget>[
          const SizedBox(width: 10),
          associationKinds.when(
            data: (data) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  RadioChip(
                    label: "Toutes",
                    selected: kind.value == "",
                    onTap: () {
                      kind.value = "";
                      kindNotifier.setKind("");
                      associationsNotifier.filterAssociationList(nameFilter, kind.value);
                  }),
                  ...data.kinds
                      .map((e) => RadioChip(
                          label: e,
                          selected: kind.value == e,
                          onTap: () {
                            kind.value = e;
                            kindNotifier.setKind(e);
                            associationsNotifier.filterAssociationList(nameFilter, kind.value);
                          }))
                      .toList()
                  ]
                )
              );
            },
            error: (error, stackTrace) =>
                const Text(PhonebookTextConstants.errorRoleTagsLoading),
            loading: () => const CircularProgressIndicator()),
          const SizedBox(height: 10),
          const AssociationResearchBar(),
          const SizedBox(height: 10),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  pageNotifier
                      .setPhonebookPage(PhonebookPage.associationCreation);
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    height: 58,
                    margin: const EdgeInsets.all(10),
                    child: Row(
                        children: const [Spacer(), Icon(Icons.add), Spacer()])),
              ),
              ...associations.when(
                  data: (associations) {
                    return associations
                        .map((association) => EditableAssociationCard(
                              association: association,
                              onEdit: () {
                                associationNotifier.setAssociation(association);
                                pageNotifier.setPhonebookPage(
                                    PhonebookPage.associationEditor);
                              },
                              onDelete: () async {
                                final result = await associationsNotifier
                                    .deleteAssociation(association);
                                if (result) {
                                  displayToastWithContext(
                                      TypeMsg.msg,
                                      PhonebookTextConstants
                                          .deletedAssociation);
                                } else {
                                  displayToastWithContext(TypeMsg.error,
                                      PhonebookTextConstants.deletingError);
                                }
                                associationsNotifier.loadAssociations();
                              },
                            ))
                        .toList();
                  },
                  loading: () =>
                      const [Center(child: CircularProgressIndicator())],
                  error: (error, stack) => [
                        const Center(
                            child: Text(PhonebookTextConstants
                                .errorLoadAssociationList))
                      ])
            ],
          ),
        ]));
  }
}

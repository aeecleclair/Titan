import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/research_filter_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:myecl/phonebook/ui/radio_chip.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/association_research_bar.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/editable_association_card.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationsNotifier =
        ref.watch(asyncAssociationListProvider.notifier);
    final associations = ref.watch(asyncAssociationListProvider);
    final roleNotifier = ref.watch(rolesTagsProvider.notifier);
    final associationKinds = ref.watch(associationKindsProvider);
    final kind = useState('');
    final kindNotifier = ref.watch(associationKindProvider.notifier);
    final nameFilter = ref.watch(filterProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhonebookTemplate(
        child: Refresher(
            onRefresh: () async {
              await associationsNotifier.loadAssociations();
              await roleNotifier.loadRolesTags();
            },
            child: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(30),
                child: AssociationResearchBar(),
              ),
              const SizedBox(height: 10),
              associationKinds.when(
                  data: (data) {
                    return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(children: [
                          const SizedBox(
                            width: 20,
                          ),
                          RadioChip(
                              label: PhonebookTextConstants.all,
                              selected: kind.value == "",
                              onTap: () {
                                kind.value = "";
                                kindNotifier.setKind("");
                                associationsNotifier.filterAssociationList(
                                    nameFilter, kind.value);
                              }),
                          ...data.kinds
                              .map((e) => RadioChip(
                                  label: e,
                                  selected: kind.value == e,
                                  onTap: () {
                                    kind.value = e;
                                    kindNotifier.setKind(e);
                                    associationsNotifier.filterAssociationList(
                                        nameFilter, kind.value);
                                  }))
                              .toList(),
                          const SizedBox(
                            width: 20,
                          ),
                        ]));
                  },
                  error: (error, stackTrace) =>
                      const Text(PhonebookTextConstants.errorRoleTagsLoading),
                  loading: () => const CircularProgressIndicator()),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        QR.to(PhonebookRouter.root +
                            PhonebookRouter.admin +
                            PhonebookRouter.createAssociaiton);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 2)
                              ]),
                          height: 60,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Center(
                              child: Icon(Icons.add,
                                  color: Colors.black, size: 40))),
                    ),
                    ...associations.when(
                        data: (associations) {
                          return associations
                              .map((association) => EditableAssociationCard(
                                  association: association,
                                  onEdit: () {
                                    associationNotifier
                                        .setAssociation(association);
                                    QR.to(PhonebookRouter.root +
                                        PhonebookRouter.admin +
                                        PhonebookRouter.editAssociation);
                                  },
                                  onDelete: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomDialogBox(
                                          title:
                                              PhonebookTextConstants.deleting,
                                          descriptions: PhonebookTextConstants
                                              .deleteAssociation,
                                          onYes: () async {
                                            final result =
                                                await associationsNotifier
                                                    .deleteAssociation(
                                                        association);
                                            if (result) {
                                              displayToastWithContext(
                                                  TypeMsg.msg,
                                                  PhonebookTextConstants
                                                      .deletedAssociation);
                                            } else {
                                              displayToastWithContext(
                                                  TypeMsg.error,
                                                  PhonebookTextConstants
                                                      .deletingError);
                                            }
                                            associationsNotifier
                                                .loadAssociations();
                                          },
                                        );
                                      },
                                    );
                                  }))
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
              ),
            ])));
  }
}

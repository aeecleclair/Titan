import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/tools/function.dart';
import 'package:myecl/phonebook/ui/kinds_bar.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/association_research_bar.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/editable_association_card.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationList = ref.watch(associationListProvider);
    final roleNotifier = ref.watch(rolesTagsProvider.notifier);
    final associationKinds = ref.watch(associationKindsProvider);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhonebookTemplate(
      child: Refresher(
        onRefresh: () async {
          await associationListNotifier.loadAssociations();
          await roleNotifier.loadRolesTags();
        },
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(30),
              child: AssociationResearchBar(),
            ),
            const SizedBox(height: 10),
            AsyncChild(
              value: associationKinds,
              builder: (context, kinds) => AsyncChild(
                  value: associationList,
                  builder: (context, associations) {
                    associations = sortedAssociation(associations, kinds);
                    return Column(
                      children: [
                        const KindsBar(),
                        GestureDetector(
                          onTap: () {
                            QR.to(PhonebookRouter.root +
                                PhonebookRouter.admin +
                                PhonebookRouter.createAssociaiton);
                          },
                          child: CardLayout(
                              margin: const EdgeInsets.only(
                                  bottom: 10, top: 20, left: 40, right: 40),
                              width: double.infinity,
                              height: 100,
                              color: Colors.white,
                              child: Center(
                                  child: HeroIcon(
                                HeroIcons.plus,
                                size: 40,
                                color: Colors.grey.shade500,
                              ))),
                        ),
                        const SizedBox(height: 30),
                        if (associations.isEmpty)
                          const Center(
                            child:
                                Text(PhonebookTextConstants.noAssociationFound),
                          )
                        else
                          ...associations.map(
                            (association) => EditableAssociationCard(
                              association: association,
                              onEdit: () {
                                associationNotifier.setAssociation(association);
                                QR.to(PhonebookRouter.root +
                                    PhonebookRouter.admin +
                                    PhonebookRouter.editAssociation);
                              },
                              onDelete: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      title: PhonebookTextConstants.deleting,
                                      descriptions: PhonebookTextConstants
                                          .deleteAssociation,
                                      onYes: () async {
                                        final result =
                                            await associationListNotifier
                                                .deleteAssociation(association);
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
                                        associationListNotifier
                                            .loadAssociations(); // TODO
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

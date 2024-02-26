import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/filtered_association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/providers/research_filter_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/association_research_bar.dart';
import 'package:myecl/phonebook/ui/association_card.dart';
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
    final filteredAssociations = useState(AsyncValue<List<Association>>);
    final associations = ref.watch(associationListProvider);
    final roleNotifier = ref.watch(rolesTagsProvider.notifier);
    final filterNotifier = ref.watch(filterProvider.notifier);
    final filteredAssociationListNotifier = ref.watch(filteredAssociationListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Refresher(
      onRefresh: () async {
      await associationsNotifier.loadAssociations();
      await roleNotifier.loadRolesTags();
      },
      child: Column(
        children:
          <Widget> [const SizedBox(width: 10),
          const AssociationResearchBar(),
          const SizedBox(width: 10),
          Column(
            children: <Widget>[
                GestureDetector(
                  onTap: () {
                    pageNotifier.setPhonebookPage(PhonebookPage.associationCreation);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    height: 58,
                    margin: const EdgeInsets.all(10),
                    child: Row(children: const [Spacer(), Icon(Icons.add), Spacer()])
                  ),
            ), 
            ...associations.when(
              data: (associations) {
                return associations.map((association) => EditableAssociationCard(
                  association: association,
                  onEdit: () {
                    associationNotifier.setAssociation(association);
                    pageNotifier.setPhonebookPage(PhonebookPage.associationEditor);
                  },
                  onDelete: () async {
                    final result = await associationsNotifier.deleteAssociation(association);
                    if (result) {
                      displayToastWithContext(TypeMsg.msg, PhonebookTextConstants.deletedAssociation);
                    } else {
                      displayToastWithContext(TypeMsg.error, PhonebookTextConstants.deletingError);
                    }
                    associationsNotifier.loadAssociations();

                  },)
                ).toList();},
              loading: () => const [Center(child: CircularProgressIndicator())],
              error: (error, stack) => [const Center(child: Text(PhonebookTextConstants.errorLoadAssociationList))])
          ],),
          ])

      );
  }
}

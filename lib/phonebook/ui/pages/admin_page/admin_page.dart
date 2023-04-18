import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/association_research_bar.dart';
import 'package:myecl/phonebook/ui/association_card.dart';
import 'package:myecl/phonebook/ui/text_input_dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associations = ref.watch(associationListProvider);
    final associationsNotifier = ref.watch(associationListProvider.notifier);
    final roleNotifier = ref.watch(rolesTagsProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Refresher(
      onRefresh: () async {
      await associationsNotifier.loadAssociations();
      await roleNotifier.loadRolesTags();
      },
      child: Column(
        children: [
          const SizedBox(width: 10),
          const AssociationResearchBar(),
          const SizedBox(width: 10),
          associations.when(
              data: (data) {
                return Column(
                  children: 
                    <Widget>[
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
                    )] + data.map((association) => AssociationCard(association: association, onClicked: () {
                    associationNotifier.setAssociation(association);
                    pageNotifier.setPhonebookPage(PhonebookPage.associationEditor);
                  },)).toList(),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (e, s) {
                return const Center(
                 child: Text(PhonebookTextConstants.errorLoadAssociationList),
                );
              }),
        ],
      ));
  }
}

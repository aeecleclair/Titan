import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/providers/role_list_provider.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/association_research_bar.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/role_research_bar.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/role_card.dart';
import 'package:myecl/phonebook/ui/association_card.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final roles = ref.watch(roleListProvider);
    final rolesNotifier = ref.watch(roleListProvider.notifier);
    final associations = ref.watch(associationListProvider);
    final associationsNotifier = ref.watch(associationListProvider.notifier);
    final controller = ScrollController();
    return Refresher(
      onRefresh: () async {
      await associationsNotifier.loadAssociations();
      await rolesNotifier.loadRoles();
      },
      child: Column(
        children: [
          const RoleResearchBar(),
          const SizedBox(width: 10),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              controller: controller,
              child: roles.when(
                  data: (data) {
                    return Row(
                      children: data.map((e) => RoleCard(role: e)).toList(),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  error: (e, s) {
                    //return const Center(
                    //  child: Text(PhonebookTextConstants.errorLoadRoleList),
                    //);
                    return Row(
                      children: fakeRoles.map((e) => RoleCard(role: e)).toList(),
                    );
                  }),
              ),
          const SizedBox(width: 10),
          const AssociationResearchBar(),
          const SizedBox(width: 10),
          associations.when(
              data: (data) {
                return Column(
                  children: data.map((association) => AssociationCard(association: association, onClicked: () {
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
                //return const Center(
                //  child: Text(PhonebookTextConstants.errorLoadAssociationList),
                //);
                return Column(
                  children: fakeAssociations.map((association) {
                    return AssociationCard(association: association, onClicked: () {
                      associationNotifier.setAssociation(association);
                      pageNotifier.setPhonebookPage(PhonebookPage.associationEditor);
                    },);
                  }).toList(),
                );
              }),
        ],
      ));
  }
}

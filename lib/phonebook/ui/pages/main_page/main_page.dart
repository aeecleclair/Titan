import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/phonebook/ui/association_card.dart';
import 'package:myecl/phonebook/ui/pages/main_page/research_bar.dart';
import 'package:myecl/tools/ui/refresher.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isAdminProvider);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationList = ref.watch(associationListProvider);
    return Stack(
        children: [ 
          Refresher(
            onRefresh: () async {
              await associationListNotifier.loadAssociations();
            },
            child: Column(
              children: [
                const SizedBox(height: 70),
                const ResearchBar(),
                const SizedBox(width: 10),
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: associationList.when(
                      data: (data) {
                        return Column(
                          children: data.map((association) {
                            return AssociationCard(association: association, onClicked: () {
                              associationNotifier.setAssociation(association);
                              pageNotifier.setPhonebookPage(PhonebookPage.associationPage);
                            },);
                          }).toList(),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      error: (e, s) {
                        // return Column(
                        //   children: fakeAssociations.map((association) {
                        //     return AssociationCard(association: association, onClicked: () {
                        //       associationNotifier.setAssociation(association);
                        //       pageNotifier.setPhonebookPage(PhonebookPage.associationPage);
                        //     },);
                        //   }).toList(),
                        // );

                        return const Center(
                         child: Text(PhonebookTextConstants.errorLoadAssociationList),
                        );
                      },
                    ))
              ],
            )),
          if (isAdmin)
            Positioned(
              top: 15,
              right: 15,
              child: GestureDetector(
                onTap: () {
                  pageNotifier.setPhonebookPage(PhonebookPage.admin);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5))
                      ]),
                  child: Row(
                    children: const [
                      HeroIcon(HeroIcons.userGroup, color: Colors.white),
                      SizedBox(width: 10),
                      Text(PhonebookTextConstants.admin,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
            )
        ],
      );
  }
}

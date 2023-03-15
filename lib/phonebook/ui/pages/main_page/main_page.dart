import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/ui/pages/main_page/association_cards.dart';
import 'package:myecl/phonebook/ui/pages/main_page/research_bar.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isAdminProvider);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final associationList = ref.watch(allAssociationListProvider);
    return Stack(
      children: [
        Column(
          children: [
            const ResearchBar(),
            const SizedBox(width: 10),
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: associationList.when(
                  data: (data) {
                    return Column(
                      children: data.map((association) {
                        return AssociationCards(association: association);
                      }).toList(),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  error: (e, s) {
                    List<Association> assos = [
                      Association(id: '1', name: 'test1', description: 'description test1'),
                      Association(id: '2', name: 'test2', description: 'description test2'),
                      Association(id: '3', name: 'test3', description: 'description test3'),
                      Association(id: '4', name: 'test4', description: 'description test4'),
                      Association(id: '5', name: 'test5', description: 'description test5'),
                      Association(id: '6', name: 'test6', description: 'description test6'),
                      Association(id: '7', name: 'test7', description: 'description test7'),
                    ];
                    return Column(
                      children: assos.map((association) {
                        return AssociationCards(association: association);
                      }).toList(),
                    );

                    //return const Center(
                    //  child: Text(PhonebookTextConstants.errorLoadAssociationList),
                    //);
                  },
                ))
          ],
        ),
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

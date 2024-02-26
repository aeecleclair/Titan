import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/research_filter_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/ui/association_card.dart';
import 'package:myecl/phonebook/ui/radio_chip.dart';
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
    final associationKindsNotifier =
        ref.watch(associationKindsProvider.notifier);
    final associationKinds = ref.watch(associationKindsProvider);
    final kind = useState('');
    final kindNotifier = ref.watch(associationKindProvider.notifier);
    final nameFilter = ref.watch(filterProvider);

    return Stack(
      children: [
        Refresher(
            onRefresh: () async {
              await associationKindsNotifier.loadAssociationKinds();
              await associationListNotifier.loadAssociations();
            },
            child: Column(
                children: [
                  const SizedBox(height: 70),
                  associationKinds.when(
                    data: (data) {
                      debugPrint("associationKinds.when data: ${data.kinds}");
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          RadioChip(
                            label: "Toutes",
                            selected: kind.value == "",
                            onTap: () {
                              kind.value = "";
                              kindNotifier.setKind("");
                              associationListNotifier.filterAssociationList(nameFilter, kind.value);
                          }),
                          ...data.kinds
                              .map((e) => RadioChip(
                                  label: e,
                                  selected: kind.value == e,
                                  onTap: () {
                                    kind.value = e;
                                    kindNotifier.setKind(e);
                                    associationListNotifier.filterAssociationList(nameFilter, kind.value);
                                  }))
                              .toList()
                          ]
                        )
                      );
                    },
                    error: (error, stackTrace) =>
                        const Text(PhonebookTextConstants.errorKindsLoading),
                    loading: () => const CircularProgressIndicator()),
                  const SizedBox(height: 30),
                  const ResearchBar(),
                  const SizedBox(height: 10),
                  ...associationList.when(
                    data: (associations) {
                      return associations
                          .map((association) => AssociationCard(
                                association: association,
                                onClicked: () {
                                  associationNotifier
                                      .setAssociation(association);
                                  pageNotifier.setPhonebookPage(
                                      PhonebookPage.associationPage);
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
                        ])])),
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
                child: const Row(
                  children: [
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

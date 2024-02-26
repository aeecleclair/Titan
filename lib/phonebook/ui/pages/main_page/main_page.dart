import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_admin_provider.dart';
import 'package:myecl/phonebook/providers/research_filter_provider.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/main_page/association_card.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:myecl/phonebook/ui/radio_chip.dart';
import 'package:myecl/phonebook/ui/pages/main_page/research_bar.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhonebookMainPage extends HookConsumerWidget {
  const PhonebookMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isPhonebookAdminProvider);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationListNotifier =
        ref.watch(asyncAssociationListProvider.notifier);
    final associationList = ref.watch(asyncAssociationListProvider);
    final associationKindsNotifier =
        ref.watch(associationKindsProvider.notifier);
    final associationKinds = ref.watch(associationKindsProvider);
    final kind = useState('');
    final kindNotifier = ref.watch(associationKindProvider.notifier);
    final nameFilter = ref.watch(filterProvider);

    return PhonebookTemplate(
        child: Refresher(
            onRefresh: () async {
              await associationKindsNotifier.loadAssociationKinds();
              await associationListNotifier.loadAssociations();
            },
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    const ResearchBar(),
                    if (isAdmin) const SizedBox(width: 20),
                    if (isAdmin)
                      GestureDetector(
                        onTap: () {
                          QR.to(PhonebookRouter.root + PhonebookRouter.admin);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
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
                              HeroIcon(HeroIcons.userGroup,
                                  color: Colors.white),
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
                  ],
                ),
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
                                associationListNotifier.filterAssociationList(
                                    nameFilter, kind.value);
                              }),
                          ...data.kinds
                              .map((e) => RadioChip(
                                  label: e,
                                  selected: kind.value == e,
                                  onTap: () {
                                    kind.value = e;
                                    kindNotifier.setKind(e);
                                    associationListNotifier
                                        .filterAssociationList(
                                            nameFilter, kind.value);
                                  }))
                              .toList(),
                          const SizedBox(
                            width: 20,
                          ),
                        ]));
                  },
                  error: (error, stackTrace) =>
                      const Text(PhonebookTextConstants.errorKindsLoading),
                  loading: () => const CircularProgressIndicator()),
              const SizedBox(height: 30),
              ...associationList.when(
                  data: (associations) {
                    return associations
                        .map((association) => AssociationCard(
                              association: association,
                              onClicked: () {
                                associationNotifier.setAssociation(association);
                                QR.to(PhonebookRouter.root +
                                    PhonebookRouter.associationDetail);
                              },
                              giveMemberRole: false,
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
            ])));
  }
}

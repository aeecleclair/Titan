import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_admin_provider.dart';
import 'package:myecl/phonebook/providers/research_filter_provider.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/tools/function.dart';
import 'package:myecl/phonebook/ui/pages/main_page/association_card.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:myecl/phonebook/ui/pages/main_page/research_bar.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../../tools/ui/widgets/admin_button.dart';

class PhonebookMainPage extends HookConsumerWidget {
  const PhonebookMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isPhonebookAdminProvider);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationList = ref.watch(associationListProvider);
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  const ResearchBar(),
                  if (isAdmin)
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: AdminButton(
                        onTap: () {
                          QR.to(PhonebookRouter.root + PhonebookRouter.admin);
                        },
                      ),
                    )
                ],
              ),
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
                      HorizontalListView.builder(
                          height: 40,
                          items: kinds.kinds,
                          firstChild: ItemChip(
                              selected: kind.value == "",
                              onTap: () {
                                kind.value = "";
                                kindNotifier.setKind("");
                                associationListNotifier.filterAssociationList(
                                    nameFilter, kind.value);
                              },
                              child: Text(PhonebookTextConstants.all,
                                  style: TextStyle(
                                    color: kind.value == ""
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ))),
                          itemBuilder: (context, item, index) {
                            final selected = kind.value == item;
                            return ItemChip(
                              onTap: () {
                                kind.value = item;
                                kindNotifier.setKind(item);
                                associationListNotifier.filterAssociationList(
                                    nameFilter, kind.value);
                              },
                              selected: selected,
                              child: Text(item,
                                  style: TextStyle(
                                    color:
                                        selected ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                            );
                          }),
                      const SizedBox(height: 30),
                      if (associations.isEmpty)
                        const Center(
                          child:
                              Text(PhonebookTextConstants.noAssociationFound),
                        )
                      else
                        ...associations.map(
                          (association) => AssociationCard(
                            association: association,
                            onClicked: () {
                              associationNotifier.setAssociation(association);
                              QR.to(PhonebookRouter.root +
                                  PhonebookRouter.associationDetail);
                            },
                            showMemberRole: false,
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

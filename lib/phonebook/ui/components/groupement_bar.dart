import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/user/providers/user_provider.dart';

class GroupementsBar extends HookConsumerWidget {
  final bool isAdmin;
  final bool restrictToManaged;
  GroupementsBar({
    super.key,
    this.isAdmin = false,
    this.restrictToManaged = false,
  });
  final dataKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationGroupement = ref.watch(associationGroupementProvider);
    final associationGroupementNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );
    final associationGroupementList = ref.watch(
      associationGroupementListProvider,
    );
    final me = ref.watch(userProvider);
    useEffect(() {
      Future(() {
        if (associationGroupement.id != "") {
          Scrollable.ensureVisible(
            dataKey.currentContext!,
            duration: const Duration(milliseconds: 500),
            alignment: 0.5,
          );
        }
      });
      return;
    }, [dataKey]);

    return Row(
      children: [
        !restrictToManaged
            ? ItemChip(
                child: const Text(
                  "+",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  associationGroupementNotifier.resetAssociationGroupement();
                  QR.to(
                    PhonebookRouter.root +
                        PhonebookRouter.admin +
                        PhonebookRouter.addEditGroupement,
                  );
                },
              )
            : SizedBox(),
        AsyncChild(
          value: associationGroupementList,
          builder: (context, associationGroupements) {
            if (restrictToManaged) {
              associationGroupements = associationGroupements.where((group) {
                return me.groups.any(
                  (userGroup) => userGroup.id == group.managerGroupId,
                );
              }).toList();
            }
            return associationGroupements.length > 1 || isAdmin
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: associationGroupements.length,
                      itemBuilder: (context, index) {
                        final item = associationGroupements[index];
                        final selected = associationGroupement == item;
                        return ItemChip(
                          key: selected ? dataKey : null,
                          onTap: () {
                            !selected
                                ? associationGroupementNotifier
                                      .setAssociationGroupement(item)
                                : associationGroupementNotifier
                                      .resetAssociationGroupement();
                          },
                          selected: selected,
                          child: Text(
                            item.name,
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox();
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/admin/providers/structure_manager_provider.dart';
import 'package:titan/admin/providers/structure_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/ui/admin.dart';
import 'package:titan/admin/ui/components/item_card_ui.dart';
import 'package:titan/admin/ui/pages/structure_page/structure_ui.dart';
import 'package:titan/mypayment/class/structure.dart';
import 'package:titan/mypayment/providers/bank_account_holder_provider.dart';
import 'package:titan/mypayment/providers/structure_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:tuple/tuple.dart';

class StructurePage extends HookConsumerWidget {
  const StructurePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bankAccountHolder = ref.watch(bankAccountHolderProvider);
    final structures = ref.watch(structureListProvider);
    final structuresNotifier = ref.watch(structureListProvider.notifier);
    final structureNotifier = ref.watch(structureProvider.notifier);
    final structureManagerNotifier = ref.watch(
      structureManagerProvider.notifier,
    );
    ref.watch(userList);

    return AdminTemplate(
      child: Refresher(
        onRefresh: () async {
          await structuresNotifier.getStructures();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AdminTextConstants.structures,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.gradient1,
                  ),
                ),
              ),

              Async2Children(
                values: Tuple2(structures, bankAccountHolder),
                builder: (context, structures, bankAccountHolder) {
                  structures.sort(
                    (a, b) =>
                        a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                  );
                  return Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            bankAccountHolder.id == ""
                                ? AdminTextConstants.noBankAccountHolder
                                : "${AdminTextConstants.currentBankAccountHolder}: ${bankAccountHolder.name}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              structureNotifier.setStructure(Structure.empty());
                              structureManagerNotifier.setUser(
                                SimpleUser.empty(),
                              );
                              QR.to(
                                AdminRouter.root +
                                    AdminRouter.structures +
                                    AdminRouter.addEditStructure,
                              );
                            },
                            child: ItemCardUi(
                              children: [
                                const Spacer(),
                                HeroIcon(
                                  HeroIcons.plus,
                                  color: Colors.grey.shade700,
                                  size: 40,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...structures.map(
                            (structure) => StructureUi(structure: structure),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/class/seed_deposit.dart';
import 'package:myecl/seed-library/providers/is_seed_library_admin_provider.dart';
import 'package:myecl/seed-library/providers/seed_deposit_list_provider.dart';
import 'package:myecl/seed-library/providers/seed_deposit_provider.dart';
import 'package:myecl/seed-library/providers/user_seed_deposit_list_provider.dart';
import 'package:myecl/seed-library/router.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/tools/ui/layouts/column_refresher.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SeedDepositPage extends HookConsumerWidget {
  const SeedDepositPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isSeedLibraryAdminProvider);
    final seedDepositNotifier = ref.watch(seedDepositProvider.notifier);
    final seedDepositListNotifier =
        ref.watch(seedDepositSeedDepositListProvider.notifier);
    final seedDeposits = ref.watch(seedDepositSeedDepositListProvider);
    return SeedDepositTemplate(
      child: AsyncChild(
        value: seedDeposits,
        builder: (context, seedDepositList) {
          seedDepositList.sort((a, b) => b.start.compareTo(a.start));
          return ColumnRefresher(
            onRefresh: () async {
              await seedDepositListNotifier.loadConfirmedSeedDeposit();
            },
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        seedDepositList.isEmpty
                            ? SeedLibraryTextConstants.noSeedDeposit
                            : SeedLibraryTextConstants.mySeedDeposits,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      if (isAdmin)
                        AdminButton(
                          onTap: () {
                            QR.to(SeedLibraryRouter.root +
                                SeedLibraryRouter.admin);
                          },
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  seedDepositNotifier.setSeedDeposit(SeedDeposit.empty());
                  QR.to(SeedLibraryRouter.root + SeedLibraryRouter.addEdit);
                },
                child: CardLayout(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                    top: 20,
                    left: 40,
                    right: 40,
                  ),
                  width: double.infinity,
                  height: 100,
                  color: Colors.white,
                  child: Center(
                    child: HeroIcon(
                      HeroIcons.plus,
                      size: 40,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
              ...seedDepositList.map(
                (seedDeposit) => SeedDepositUi(
                  seedDeposit: seedDeposit,
                ),
              ),
              const SizedBox(height: 80),
            ],
          );
        },
      ),
    );
  }
}

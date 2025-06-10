import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/providers/ph_list_provider.dart';
import 'package:titan/ph/providers/ph_provider.dart';
import 'package:titan/ph/providers/selected_year_list_provider.dart';
import 'package:titan/ph/router.dart';
import 'package:titan/ph/tools/constants.dart';
import 'package:titan/ph/ui/pages/admin_page/admin_ph_card.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminPhList extends HookConsumerWidget {
  const AdminPhList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phNotifier = ref.watch(phProvider.notifier);
    final phList = ref.watch(phListProvider);
    final phListNotifier = ref.watch(phListProvider.notifier);
    final selectedYear = ref.watch(selectedYearListProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AsyncChild(
        value: phList,
        builder: (context, phList) {
          final list = phList.where(
            (ph) => selectedYear.contains(ph.date.year),
          );
          return Column(
            children: list
                .map(
                  (ph) => AdminPhCard(
                    ph: ph,
                    onEdit: () {
                      QR.to(PhRouter.root + PhRouter.admin + PhRouter.add_ph);
                      phNotifier.setPh(ph);
                    },
                    onDelete: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialogBox(
                            title: PhTextConstants.delete,
                            descriptions: PhTextConstants.irreversibleAction,
                            onYes: () {
                              phListNotifier.deletePh(ph);
                            },
                          );
                        },
                      );
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

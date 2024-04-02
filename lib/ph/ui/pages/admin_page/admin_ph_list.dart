import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/ui/pages/admin_page/admin_ph_card.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminPhList extends HookConsumerWidget {
  const AdminPhList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phNotifier = ref.watch(phProvider.notifier);
    final phList = ref.watch(phListProvider);
    final phListNotifier = ref.watch(phListProvider.notifier);
    return AsyncChild(
        value: phList,
        builder: (context, phList) {
          return Column(
              children: phList
                  .map((ph) => AdminPhCard(
                        ph: ph,
                        onEdit: () {
                          QR.to(
                              PhRouter.root + PhRouter.admin + PhRouter.add_ph);
                          phNotifier.setPh(ph);
                        },
                        onDelete: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialogBox(
                                title: "Delete",
                                descriptions: "Ddelete",
                                onYes: () {
                                  phListNotifier.deletePh(ph);
                                },
                              );
                            },
                          );
                        },
                      ))
                  .toList());
        });
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/ui/pages/admin_page/ph_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhList extends HookConsumerWidget {
  const PhList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PhNotifier phNotifier = ref.watch(phProvider.notifier);
    final phList = ref.watch(phListProvider);
    return AsyncChild(
        value: phList,
        builder: (context, phList) {
          return Column(
              children: phList
                  .map((ph) => PhCard(
                        ph: ph,
                        onEdit: () {
                          QR.to(
                              PhRouter.root + PhRouter.admin + PhRouter.add_ph);
                          phNotifier.setPh(ph);
                        },
                      ))
                  .toList());
        });
  }
}

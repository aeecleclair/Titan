import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_pdf_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/ui/pages/past_ph_selection_page/ph_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhList extends HookConsumerWidget {
  const PhList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phList = ref.watch(phListProvider);
    final phPdfNotifier = ref.watch(phPdfProvider.notifier);
    return AsyncChild(
        value: phList,
        builder: (context, phList) {
          return Column(
              children: phList
                  .map((ph) => PhCard(
                        ph: ph,
                        onView: () async {
                          await phPdfNotifier.loadPhPdf(ph.id);
                          QR.to(PhRouter.root +
                              PhRouter.past_ph_selection +
                              PhRouter.view_ph);
                        },
                      ))
                  .toList());
        });
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/providers/ph_send_pdf_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/ui/button.dart';
import 'package:myecl/ph/ui/pages/admin_page/admin_ph_list.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phNotifier = ref.watch(phProvider.notifier);
    final phSendPdfNotifier = ref.watch(phSendPdfProvider.notifier);
    final phListNotifier = ref.watch(phListProvider.notifier);
    return PhTemplate(
      child: Refresher(
        onRefresh: () async {
          await phListNotifier.loadPhList();
        },
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.sizeOf(context).height - 224,
                child: const SingleChildScrollView(child: AdminPhList())),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                phNotifier.setPh(Ph.empty());
                phSendPdfNotifier.set(Uint8List(0));
                QR.to(PhRouter.root + PhRouter.admin + PhRouter.add_ph);
              },
              child: const MyButton(
                text: "Ajouter un nouveau journal",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

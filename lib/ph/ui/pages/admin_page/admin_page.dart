import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/ph/providers/file_picker_result_provider.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/providers/ph_send_pdf_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/tools/constants.dart';
import 'package:myecl/ph/ui/button.dart';
import 'package:myecl/ph/ui/components/year_bar.dart';
import 'package:myecl/ph/ui/pages/admin_page/admin_ph_list.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phNotifier = ref.watch(phProvider.notifier);
    final phSendPdfNotifier = ref.watch(phSendPdfProvider.notifier);
    final resultNotifier = ref.watch(filePickerResultProvider.notifier);
    return PhTemplate(
      child: Column(
        children: [
          const YearBar(),
          const Expanded(child: SingleChildScrollView(child: AdminPhList())),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              phNotifier.setPh(PaperComplete.fromJson({}));
              phSendPdfNotifier.set(Uint8List(0));
              resultNotifier.setFilePickerResult(null);
              QR.to(PhRouter.root + PhRouter.admin + PhRouter.add_ph);
            },
            child: const MyButton(
              text: PhTextConstants.addNewJournal,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

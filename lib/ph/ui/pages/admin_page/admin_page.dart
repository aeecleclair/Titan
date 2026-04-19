import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/ph/class/ph.dart';
import 'package:titan/ph/providers/file_picker_result_provider.dart';
import 'package:titan/ph/providers/ph_provider.dart';
import 'package:titan/ph/providers/ph_send_pdf_provider.dart';
import 'package:titan/ph/router.dart';
import 'package:titan/ph/ui/button.dart';
import 'package:titan/ph/ui/components/year_bar.dart';
import 'package:titan/ph/ui/pages/admin_page/admin_ph_list.dart';
import 'package:titan/ph/ui/pages/ph.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phNotifier = ref.watch(phProvider.notifier);
    final phSendPdfNotifier = ref.watch(phSendPdfProvider.notifier);
    final resultNotifier = ref.watch(filePickerResultProvider.notifier);
    final scrollController = useScrollController();
    return PhTemplate(
      child: Column(
        children: [
          const YearBar(),
          Expanded(
            child: ScrollToHideNavbar(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                child: const AdminPhList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              phNotifier.setPh(Ph.empty());
              phSendPdfNotifier.set(Uint8List(0));
              resultNotifier.setFilePickerResult(null);
              QR.to(PhRouter.root + PhRouter.admin + PhRouter.add_ph);
            },
            child: MyButton(
              text: AppLocalizations.of(context)!.phAddNewJournal,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

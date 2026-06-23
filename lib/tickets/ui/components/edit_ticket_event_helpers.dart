import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/providers/ticket_event_edit_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/confirm_modal.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorConstants.secondary.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

Future<bool> showDeleteConfirm(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context)!;
  var confirmed = false;
  await showCustomBottomModal(
    context: context,
    ref: ref,
    modal: ConfirmModal(
      title: l10n.ticketsDeleteConfirm,
      description: l10n.globalIrreversibleAction,
      onYes: () => confirmed = true,
    ),
  );
  return confirmed;
}

void showEditError(
  BuildContext context,
  WidgetRef ref,
  AppLocalizations l10n, {
  String? fallbackDueSales,
  String? fallbackDueAnswers,
}) {
  final error = ref.read(ticketEventEditProvider).error;
  if (error is AppException) {
    final message = error.message;
    if (message.contains('checkouts or tickets') && fallbackDueSales != null) {
      displayToast(context, TypeMsg.error, fallbackDueSales);
      return;
    }
    if (message.contains('answers') && fallbackDueAnswers != null) {
      displayToast(context, TypeMsg.error, fallbackDueAnswers);
      return;
    }
    displayToast(context, TypeMsg.error, message);
    return;
  }
  displayToast(context, TypeMsg.error, l10n.ticketsUpdateError);
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
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

/// Reports a refused edit, with [reason] naming the cause the call site can
/// already anticipate — a delete the backend only rejects because rows depend
/// on the row being removed.
void showEditError(
  BuildContext context,
  AppLocalizations l10n, {
  String? reason,
}) {
  displayToast(context, TypeMsg.error, reason ?? l10n.ticketsUpdateError);
}

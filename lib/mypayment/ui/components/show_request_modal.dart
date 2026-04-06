import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/mypayment/class/payment_request.dart';
import 'package:titan/mypayment/class/secured_content_data.dart';
import 'package:titan/mypayment/providers/payment_requests_provider.dart';
import 'package:titan/mypayment/tools/key_service.dart';
import 'package:titan/mypayment/ui/components/paiment_delegate/paiment_delegate_modal.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';

Future<void> showRequestModal({
  required BuildContext context,
  required WidgetRef ref,
  required PaymentRequest request,
  VoidCallback? onSuccess,
}) async {
  final keyService = KeyService();
  final paymentRequestsNotifier = ref.read(paymentRequestsProvider.notifier);

  await showCustomBottomModal(
    context: context,
    ref: ref,
    modal: PaimentDelegateModal(
      itemTitle: request.name,
      itemDescription: request.storeNote ?? '',
      itemPrice: request.total,
      onConfirm: () async {
        final keyId = await keyService.getKeyId();
        final keyPair = await keyService.getKeyPair();
        if (keyId == null || keyPair == null) {
          if (context.mounted) {
            Navigator.of(context).pop();
            displayToast(
              context,
              TypeMsg.error,
              AppLocalizations.of(context)!.paiementPaymentRequestError,
            );
          }
          return;
        }
        final now = DateTime.now();
        final validationData = SecuredContentData(
          id: request.id,
          key: keyId,
          iat: now,
          tot: request.total,
          store: true,
        );
        final validation = await keyService.signContent(validationData);
        if (validation == null) {
          if (context.mounted) {
            Navigator.of(context).pop();
            displayToast(
              context,
              TypeMsg.error,
              AppLocalizations.of(context)!.paiementPaymentRequestError,
            );
          }
          return;
        }
        final success = await paymentRequestsNotifier.acceptRequest(
          request,
          validation,
        );
        if (context.mounted) {
          Navigator.of(context).pop();
          displayToast(
            context,
            success ? TypeMsg.msg : TypeMsg.error,
            success
                ? AppLocalizations.of(context)!.paiementPaymentRequestAccepted
                : AppLocalizations.of(context)!.paiementPaymentRequestError,
          );
          if (success) onSuccess?.call();
        }
      },
      onRefuse: () async {
        final success = await paymentRequestsNotifier.refuseRequest(request);
        if (context.mounted) {
          Navigator.of(context).pop();
          displayToast(
            context,
            success ? TypeMsg.msg : TypeMsg.error,
            success
                ? AppLocalizations.of(context)!.paiementPaymentRequestRefused
                : AppLocalizations.of(context)!.paiementPaymentRequestError,
          );
        }
      },
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/class/user_ticket.dart';
import 'package:titan/tickets/providers/ticket_change_over_provider.dart';
import 'package:titan/tickets/providers/user_tickets_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';

final _emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

class OfferTicketModal extends HookConsumerWidget {
  final UserTicket ticket;

  const OfferTicketModal({super.key, required this.ticket});

  String _errorMessage(AppLocalizations l10n, String error) {
    if (error.contains('User is not the owner')) {
      return l10n.ticketsOfferNotOwner;
    }
    if (error.contains('Ticket not found')) {
      return l10n.ticketsOfferNotFound;
    }
    return l10n.ticketsOfferError;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final changeOverState = ref.watch(ticketChangeOverProvider);
    final isLoading = changeOverState.isLoading;

    return BottomModalTemplate(
      title: ticket.eventName,
      description: l10n.ticketsOfferDescription,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextEntry(
              label: l10n.settingsEmail,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (!_emailRegex.hasMatch(value.trim())) {
                  return l10n.ticketsOfferInvalidEmail;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            WaitingButton(
              isLoading: isLoading,
              waitingColor: ColorConstants.background,
              builder: (child) => Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: ColorConstants.tertiary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ColorConstants.onTertiary),
                ),
                child: Center(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: ColorConstants.background,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                    child: child,
                  ),
                ),
              ),
              onTap: isLoading
                  ? null
                  : () async {
                      if (!formKey.currentState!.validate()) return;

                      final success = await ref
                          .read(ticketChangeOverProvider.notifier)
                          .requestChangeOver(
                            ticket.id,
                            emailController.text.trim(),
                          );

                      if (!context.mounted) return;

                      if (success) {
                        Navigator.of(context).pop();
                        displayToast(
                          context,
                          TypeMsg.msg,
                          l10n.ticketsOfferSuccess,
                        );
                        await ref
                            .read(userTicketsProvider.notifier)
                            .loadUserTickets();
                      } else {
                        final error = ref.read(ticketChangeOverProvider).error;
                        displayToast(
                          context,
                          TypeMsg.error,
                          error != null
                              ? _errorMessage(l10n, error.toString())
                              : l10n.ticketsOfferError,
                        );
                      }
                    },
              child: Text(l10n.ticketsOfferTicket),
            ),
          ],
        ),
      ),
    );
  }
}

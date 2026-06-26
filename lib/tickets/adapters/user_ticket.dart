import 'package:titan/generated/openapi.models.swagger.dart'
    show AppCoreTicketsSchemasTicketsTicketComplete;

/// Why a ticket cannot be handed over to somebody else, if it cannot.
enum TicketTransferBlockReason { transferable, alreadyUsed, sessionPast }

// Backend stores price in cents; the UI works in euros.
extension $AppCoreTicketsSchemasTicketsTicketComplete
    on AppCoreTicketsSchemasTicketsTicketComplete {
  int get priceInEuros => price ~/ 100;

  TicketTransferBlockReason get transferBlockReason {
    if (scanned) {
      return TicketTransferBlockReason.alreadyUsed;
    }
    if (session.id.isNotEmpty &&
        session.startDatetime.isBefore(DateTime.now())) {
      return TicketTransferBlockReason.sessionPast;
    }
    return TicketTransferBlockReason.transferable;
  }

  bool get isTransferable =>
      transferBlockReason == TicketTransferBlockReason.transferable;
}

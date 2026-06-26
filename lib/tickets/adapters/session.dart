import 'package:titan/generated/openapi.models.swagger.dart';

extension $SessionAdmin on SessionAdmin {
  SessionUpdate toSessionUpdate() => SessionUpdate(
    name: name,
    startDatetime: startDatetime,
    quota: quota,
    disabled: disabled,
  );
}

extension $SessionComplete on SessionComplete {
  /// The create endpoint answers with a [SessionComplete]; the event holds
  /// [SessionAdmin], which adds the sales counters. A session that was just
  /// created cannot have been bought into yet, so both are zero.
  SessionAdmin toSessionAdmin() => SessionAdmin(
    id: id,
    eventId: eventId,
    name: name,
    startDatetime: startDatetime,
    disabled: disabled,
    quota: quota,
    ticketsInCheckout: 0,
    ticketsSold: 0,
  );
}

import 'package:titan/generated/openapi.models.swagger.dart';

/// Lifecycle of a ticket event, derived client-side from its open/close dates.
enum TicketEventStatus { open, closed, upcoming, disabled }

TicketEventStatus _statusFrom(
  bool disabled,
  DateTime openDatetime,
  DateTime? closeDatetime,
) {
  if (disabled) return TicketEventStatus.disabled;
  final now = DateTime.now();
  if (closeDatetime != null && closeDatetime.isBefore(now)) {
    return TicketEventStatus.closed;
  }
  if (openDatetime.isAfter(now)) return TicketEventStatus.upcoming;
  return TicketEventStatus.open;
}

extension $EventAdmin on EventAdmin {
  // The generated payload serialises nulls, so every field has to be sent back
  // or the backend would clear the ones the caller does not set.
  EventUpdate toEventUpdate() => EventUpdate(
    name: name,
    quota: quota,
    openDatetime: openDatetime,
    closeDatetime: closeDatetime,
    disabled: disabled,
  );

  TicketEventStatus get status =>
      _statusFrom(disabled, openDatetime, closeDatetime);
}

extension $EventSimple on EventSimple {
  TicketEventStatus get status =>
      _statusFrom(disabled, openDatetime, closeDatetime);
}

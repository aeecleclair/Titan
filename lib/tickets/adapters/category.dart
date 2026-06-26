import 'package:titan/generated/openapi.models.swagger.dart';

// Backend stores price in cents; the UI works in euros.
extension $CategoryAdmin on CategoryAdmin {
  int get priceInEuros => price ~/ 100;

  CategoryUpdate toCategoryUpdate() => CategoryUpdate(
    name: name,
    price: price,
    quota: quota,
    requiredMembership: requiredMembership,
    disabled: disabled,
  );
}

extension $CategoryPublic on CategoryPublic {
  int get priceInEuros => price ~/ 100;
}

extension $CategoryComplete on CategoryComplete {
  /// The create endpoint answers with a [CategoryComplete]; the event holds
  /// [CategoryAdmin], which adds the sales counters. A category that was just
  /// created cannot have been bought into yet, so both are zero.
  CategoryAdmin toCategoryAdmin() => CategoryAdmin(
    id: id,
    eventId: eventId,
    name: name,
    price: price,
    requiredMembership: requiredMembership,
    disabled: disabled,
    quota: quota,
    ticketsInCheckout: 0,
    ticketsSold: 0,
  );
}

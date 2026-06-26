import 'package:titan/generated/openapi.models.swagger.dart'
    show CheckoutResponse;

// Backend stores price in cents; the UI works in euros.
extension $CheckoutResponse on CheckoutResponse {
  int get priceInEuros => price ~/ 100;
}

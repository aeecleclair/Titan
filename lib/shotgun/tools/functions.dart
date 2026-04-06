import 'package:titan/shotgun/class/checkout.dart';
import 'package:titan/shotgun/class/shotgun.dart';

Checkout checkoutFromShotgun(Shotgun shotgun) {
  return Checkout(
    categoryId: shotgun.categories.first.id,
    sessionId: shotgun.sessions.first.id,
  );
}

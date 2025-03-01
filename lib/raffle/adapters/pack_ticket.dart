import 'package:myecl/generated/openapi.models.swagger.dart';

extension $PackTicketSimple on PackTicketSimple {
  PackTicketBase toPackTicketBase() {
    return PackTicketBase(price: price, packSize: packSize, raffleId: raffleId);
  }
}

import 'package:myecl/generated/openapi.models.swagger.dart';

extension $PrizeSimple on PrizeSimple {
  PrizeBase toPrizeBase() {
    return PrizeBase(
        name: name,
        description: description,
        raffleId: raffleId,
        quantity: quantity);
  }
}

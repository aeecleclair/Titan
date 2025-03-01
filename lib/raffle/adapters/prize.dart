import 'package:myecl/generated/openapi.models.swagger.dart';

extension $PrizeSimple on PrizeSimple {
  PrizeBase toPrizeBase() {
    return PrizeBase(
        name: name,
        description: description,
        raffleId: raffleId,
        quantity: quantity);
  }

  PrizeEdit toPrizeEdit() {
    return PrizeEdit(
      raffleId: raffleId,
      description: description,
      name: name,
      quantity: quantity,
    );
  }
}

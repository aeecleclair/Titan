import 'package:myecl/generated/openapi.models.swagger.dart';

extension $DeliveryReturn on DeliveryReturn {
  DeliveryBase toDeliveryBase() {
    return DeliveryBase(deliveryDate: deliveryDate);
  }

  DeliveryUpdate toDeliveryUpdate() {
    return DeliveryUpdate(
      deliveryDate: deliveryDate,
    );
  }
}

import 'package:titan/generated/openapi.models.swagger.dart';

extension $DeliveryReturn on DeliveryReturn {
  DeliveryBase toDeliveryBase() {
    return DeliveryBase(deliveryDate: deliveryDate, name: name);
  }
}

import 'package:myecl/generated/openapi.models.swagger.dart';

extension $OrderReturn on OrderReturn {
  OrderBase toOrderBase() {
    return OrderBase(
      userId: user.id,
      deliveryId: deliveryId,
      productsIds: productsdetail.map((p) => p.product.id).toList(),
      collectionSlot: collectionSlot,
      productsQuantity: productsdetail.map((p) => p.quantity).toList(),
    );
  }

  OrderEdit toOrderEdit() {
    return OrderEdit(
      collectionSlot: collectionSlot,
      productsIds: productsdetail.map((p) => p.product.id).toList(),
      productsQuantity: productsdetail.map((p) => p.quantity).toList(),
    );
  }
}

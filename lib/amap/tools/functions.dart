import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/order.dart';

String collectionSlotToString(CollectionSlot slot) {
  switch (slot) {
    case CollectionSlot.midDay:
      return 'midi';
    case CollectionSlot.evening:
      return 'soir';
  }
}

CollectionSlot stringToCollectionSlot(String slot) {
  switch (slot) {
    case 'midi':
      return CollectionSlot.midDay;
    case 'soir':
      return CollectionSlot.evening;
    default:
      return CollectionSlot.midDay;
  }
}

String deliveryStatusToString(DeliveryStatus status) {
  switch (status) {
    case DeliveryStatus.creation:
      return 'creation';
    case DeliveryStatus.available:
      return 'orderable';
    case DeliveryStatus.locked:
      return 'locked';
    case DeliveryStatus.delivered:
      return 'delivered';
  }
}

DeliveryStatus stringToDeliveryStatus(String status) {
  switch (status) {
    case 'creation':
      return DeliveryStatus.creation;
    case 'orderable':
      return DeliveryStatus.available;
    case 'locked':
      return DeliveryStatus.locked;
    case 'delivered':
      return DeliveryStatus.delivered;
    default:
      return DeliveryStatus.creation;
  }
}

import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/order.dart';

String collectionSlotToString(CollectionSlot slot) {
  switch (slot) {
    case CollectionSlot.midi:
      return 'midi';
    case CollectionSlot.soir:
      return 'soir';
    default:
      return 'midi';
  }
}

CollectionSlot stringToCollectionSlot(String slot) {
  switch (slot) {
    case 'midi':
      return CollectionSlot.midi;
    case 'soir':
      return CollectionSlot.soir;
    default:
      return CollectionSlot.midi;
  }
}

String deliveryStatusToString(DeliveryStatus status) {
  switch (status) {
    case DeliveryStatus.creation:
      return 'creation';
    case DeliveryStatus.orderable:
      return 'orderable';
    case DeliveryStatus.locked:
      return 'locked';
    case DeliveryStatus.deliverd:
      return 'delivered';
  }
}

DeliveryStatus stringToDeliveryStatus(String status) {
  switch (status) {
    case 'creation':
      return DeliveryStatus.creation;
    case 'orderable':
      return DeliveryStatus.orderable;
    case 'locked':
      return DeliveryStatus.locked;
    case 'delivered':
      return DeliveryStatus.deliverd;
    default:
      return DeliveryStatus.creation;
  }
}

import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/order.dart';

String collectionSlotToString(CollectionSlot slot) {
  switch (slot) {
    case CollectionSlot.midi:
      return 'Midi';
    case CollectionSlot.soir:
      return 'Soir';
    default:
      return 'Midi';
  }
}

CollectionSlot stringToCollectionSlot(String slot) {
  switch (slot) {
    case 'Midi':
      return CollectionSlot.midi;
    case 'Soir':
      return CollectionSlot.soir;
    default:
      return CollectionSlot.midi;
  }
}

String deliveryStatusToString(DeliveryStatus status) {
  switch (status) {
    case DeliveryStatus.creation:
      return 'creation';
  }
}

DeliveryStatus stringToDeliveryStatus(String status) {
  switch (status) {
    case 'creation':
      return DeliveryStatus.creation;
    default:
      return DeliveryStatus.creation;
  }
}
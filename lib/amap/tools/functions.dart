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
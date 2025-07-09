import 'package:flutter/widgets.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/class/order.dart';
import 'package:titan/l10n/app_localizations.dart';

// Slots in Titan UI must changed based on language
String uiCollectionSlotToString(CollectionSlot slot, BuildContext context) {
  switch (slot) {
    case CollectionSlot.midDay:
      return AppLocalizations.of(context)!.amapMidDay;
    case CollectionSlot.evening:
      return AppLocalizations.of(context)!.amapEvening;
  }
}

// Slots are represented with hardcoded strings in API
String apiCollectionSlotToString(CollectionSlot slot) {
  switch (slot) {
    case CollectionSlot.midDay:
      return 'midi';
    case CollectionSlot.evening:
      return 'soir';
  }
}

// Slots are represented with hardcoded strings in API
CollectionSlot apiStringToCollectionSlot(String slot) {
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

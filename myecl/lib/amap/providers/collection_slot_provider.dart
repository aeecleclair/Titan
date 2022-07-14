import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CollectionSlot {
  midi, soir
}

final collectionSlotProvider = StateNotifierProvider<CollectionSlotProvider, CollectionSlot>((ref) {
  return CollectionSlotProvider();
});

class CollectionSlotProvider extends StateNotifier<CollectionSlot> {
  CollectionSlotProvider() : super(CollectionSlot.midi);

  void setSlot(CollectionSlot i) {
    state = i;
  }

  String getText() {
    return state.toString().split(".")[1];
  }
}

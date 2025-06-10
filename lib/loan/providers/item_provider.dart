import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/class/item.dart';

class ItemNotifier extends StateNotifier<Item> {
  ItemNotifier() : super(Item.empty());

  void setItem(Item item) {
    state = item;
  }
}

final itemProvider = StateNotifierProvider<ItemNotifier, Item>((ref) {
  return ItemNotifier();
});

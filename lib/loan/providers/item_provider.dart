import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class ItemNotifier extends StateNotifier<Item> {
  ItemNotifier() : super(Item.fromJson({}));

  void setItem(Item item) {
    state = item;
  }
}

final itemProvider = StateNotifierProvider<ItemNotifier, Item>((ref) {
  return ItemNotifier();
});

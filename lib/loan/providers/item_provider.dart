import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class ItemNotifier extends StateNotifier<Item> {
  ItemNotifier() : super(EmptyModels.empty<Item>());

  void setItem(Item item) {
    state = item;
  }
}

final itemProvider = StateNotifierProvider<ItemNotifier, Item>((ref) {
  return ItemNotifier();
});

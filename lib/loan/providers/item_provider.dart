import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class ItemNotifier extends Notifier<Item> {
  @override
  Item build() {
    return Item.empty();
  }

  void setItem(Item item) {
    state = item;
  }
}

final itemProvider = NotifierProvider<ItemNotifier, Item>(ItemNotifier.new);

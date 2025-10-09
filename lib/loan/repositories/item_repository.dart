import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/tools/repository/repository.dart';

class ItemRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "loans/loaners/";

  Future<List<Item>> getItemList(String loanerId) async {
    return List<Item>.from(
      (await getList(suffix: "$loanerId/items")).map((x) => Item.fromJson(x)),
    );
  }

  Future<Item> createItem(String loanerId, Item item) async {
    return Item.fromJson(
      await create(item.toJson(), suffix: "$loanerId/items"),
    );
  }

  Future<bool> updateItem(String loanerId, Item item) async {
    return await update(item.toJson(), "$loanerId/items/${item.id}");
  }

  Future<bool> deleteItem(String loanerId, String itemId) async {
    return await delete("$loanerId/items/$itemId");
  }
}

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return ItemRepository()..setToken(token);
});

import 'package:myecl/loan/class/item.dart';
import 'package:myecl/tools/repository/repository.dart';

class ItemRepository extends Repository {
  @override
  final ext = "loans/item/";

  Future<List<Item>> getItemList() async {
    return List<Item>.from((await getList()).map((x) => Item.fromJson(x)));
  }

  Future<Item> createItem(Item item) async {
    return Item.fromJson(await create(item.toJson()));
  }

  Future<bool> updateItem(Item item) async {
    return await update(item.toJson(), item.id);
  }

  Future<bool> deleteItem(String itemId) async {
    return await delete(itemId);
  }
}

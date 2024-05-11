import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/greencode/class/greencode_item.dart';
import 'package:myecl/tools/repository/repository.dart';

class GreenCodeItemRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'greencode/';

  Future<List<GreenCodeItem>> getAllGreenCodeItems() async {
    return (await getList(suffix: 'items'))
        .map((jsonItem) => GreenCodeItem.fromJson(jsonItem))
        .toList();
  }

  Future<List<GreenCodeItem>> getCurrentUserGreenCodeItems() async {
    return (await getList(suffix: 'items/me'))
        .map((jsonItem) => GreenCodeItem.fromJson(jsonItem))
        .toList();
  }

  Future<GreenCodeItem> getGreenCodeItemByQR(String qrCodeContent) async {
    return GreenCodeItem.fromJson(await getOne(qrCodeContent));
  }

  Future<GreenCodeItem> addGreenCodeItem(GreenCodeItem item) async {
    return GreenCodeItem.fromJson(await create(item.toJson(), suffix: 'item'));
  }

  Future<bool> updateGreenCodeItem(GreenCodeItem item) async {
    return await update(item.toJson(), "item/${item.id}");
  }

  Future<bool> deleteGreenCodeItem(String itemId) async {
    return await delete("item/$itemId");
  }

  Future<bool> addCurrentUserToGreenCodeItem(String itemId) async {
    return await create("", suffix: 'item/$itemId/me');
  }

  Future<bool> removeCurrentUserFromGreenCodeItem(String itemId) async {
    return await delete("item/$itemId/me");
  }

  Future<bool> addUserToGreenCodeItem(String itemId, String userId) async {
    return await create("", suffix: 'item/$itemId/$userId');
  }

  Future<bool> removeUserFromGreenCodeItem(String itemId, String userId) async {
    return await delete("item/$itemId/$userId");
  }
}

final greencodeItemRepositoryProvider =
    Provider<GreenCodeItemRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return GreenCodeItemRepository()..setToken(token);
});

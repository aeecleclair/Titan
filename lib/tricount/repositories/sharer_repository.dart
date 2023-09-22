import 'package:myecl/tools/repository/repository.dart';

class SharerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tricount/group/";

  Future<bool> createSharer(
      String sharerGroupId, String simpleUserId, bool retroPropagate) async {
    return await update({"retroPropagate": retroPropagate},
        "$sharerGroupId/sharer/$simpleUserId");
  }

  Future<bool> deleteSharer(String sharerGroupId, String simpleUserId) async {
    return await delete("$sharerGroupId/sharer/$simpleUserId");
  }
}

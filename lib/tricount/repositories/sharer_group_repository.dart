import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tricount/class/sharer_group.dart';

class SharerGroupRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tricount/group";

  Future<List<SharerGroup>> getSharerGroupList() async {
    return List<SharerGroup>.from(
        (await getList()).map((x) => SharerGroup.fromJson(x)));
  }

  Future<SharerGroup> createSharerGroup(SharerGroup sharerGroup) async {
    return SharerGroup.fromJson(await create(sharerGroup.toJson()));
  }

  Future<bool> updateSharerGroup(SharerGroup sharerGroup) async {
    return await update(sharerGroup.toJson(), "/${sharerGroup.id}");
  }

  Future<bool> deleteSharerGroup(String sharerGroupId) async {
    return await delete("/$sharerGroupId");
  }
}

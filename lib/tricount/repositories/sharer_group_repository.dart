import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tricount/class/sharer_group.dart';

class SharerGroupRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tricount/sharergroups";

  Future<SharerGroup> getSharerGroup(String sharerGroupId) async {
    return SharerGroup.fromJson(await getOne("/$sharerGroupId"));
  }

  Future<SharerGroup> createSharerGroup(SharerGroup sharerGroup) async {
    final res = await create(sharerGroup.toJson());
    print(res);
    return SharerGroup.fromJson(res);
  }

  Future<bool> updateSharerGroup(SharerGroup sharerGroup) async {
    return await update(sharerGroup.toJson(), "/${sharerGroup.id}");
  }
}

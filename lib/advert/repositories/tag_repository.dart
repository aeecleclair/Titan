import 'package:titan/advert/class/tag.dart';
import 'package:titan/tools/repository/repository.dart';

class TagRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "advert/tag/";

  Future<List<Tag>> getAllTag() async {
    return (await getList()).map((e) => Tag.fromJson(e)).toList();
  }

  Future<Tag> getTag(String id) async {
    return Tag.fromJson(await getOne(id));
  }

  Future<Tag> addTag(Tag tag) async {
    return Tag.fromJson(await create(tag.toJson()));
  }

  Future<bool> deleteTag(String id) async {
    return await delete("/$id");
  }
}

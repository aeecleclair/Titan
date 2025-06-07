import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/meta/class/meta.dart';
import 'package:myecl/meta/repositories/meta_repository.dart';

class AdvertRepository extends MetaRepository<Meta> {
  @override
  // ignore: overridden_fields
  final ext = 'advert/';

  @override
  Future<List<Meta>> getMetas({int limit = 30, String? after}) async {
    return (await getList(suffix: 'adverts'))
        .map((e) => Meta.fromJson(e))
        .toList();
  }

  @override
  Future<Meta> getMeta(String id) async {
    return Meta.fromJson(await getOne(id));
  }

  @override
  Future<Meta> addMeta(Meta advert) async {
    return Meta.fromJson(await create(advert.toJson(), suffix: 'adverts'));
  }

  @override
  Future<bool> updateMeta(Meta advert) async {
    return await update(advert.toJson(), "adverts/${advert.id}");
  }

  @override
  Future<bool> deleteMeta(String id) async {
    return await delete("adverts/$id");
  }
}

import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/meta/repositories/meta_repository.dart';

class AdvertRepository extends MetaRepository<Advert> {
  @override
  // ignore: overridden_fields
  final ext = 'advert/';

  @override
  Future<List<Advert>> getMetas({int limit = 30, String? after}) async {
    return (await getList(suffix: 'adverts'))
        .map((e) => Advert.fromJson(e))
        .toList();
  }

  @override
  Future<Advert> getMeta(String id) async {
    return Advert.fromJson(await getOne(id));
  }

  @override
  Future<Advert> addMeta(Advert advert) async {
    return Advert.fromJson(await create(advert.toJson(), suffix: 'adverts'));
  }

  @override
  Future<bool> updateMeta(Advert advert) async {
    return await update(advert.toJson(), "adverts/${advert.id}");
  }

  @override
  Future<bool> deleteMeta(String id) async {
    return await delete("adverts/$id");
  }
}

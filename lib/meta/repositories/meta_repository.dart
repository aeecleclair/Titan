import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/tools/repository/repository.dart';

class MetaRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'advert/';

  Future<List<Advert>> getMetas({ int limit = 30, String? after }) async {
    return (await getList(suffix: 'adverts'))
        .map((e) => Advert.fromJson(e))
        .toList();
  }

  Future<Advert> getMeta(String id) async {
    return Advert.fromJson(await getOne(id));
  }

  Future<Advert> addMeta(Advert advert) async {
    return Advert.fromJson(await create(advert.toJson(), suffix: 'adverts'));
  }

  Future<bool> updateMeta(Advert advert) async {
    return await update(advert.toJson(), "adverts/${advert.id}");
  }

  Future<bool> deleteMeta(String id) async {
    return await delete("adverts/$id");
  }
}

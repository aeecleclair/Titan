import 'package:titan/advert/class/advert.dart';
import 'package:titan/tools/repository/repository.dart';

class AdvertRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'advert/';

  Future<List<Advert>> getAllAdvert() async {
    return (await getList(
      suffix: 'adverts',
    )).map((e) => Advert.fromJson(e)).toList();
  }

  Future<Advert> getAdvert(String id) async {
    return Advert.fromJson(await getOne(id));
  }

  Future<Advert> addAdvert(Advert advert) async {
    return Advert.fromJson(await create(advert.toJson(), suffix: 'adverts'));
  }

  Future<bool> updateAdvert(Advert advert) async {
    return await update(advert.toJson(), "adverts/${advert.id}");
  }

  Future<bool> deleteAdvert(String id) async {
    return await delete("adverts/$id");
  }
}

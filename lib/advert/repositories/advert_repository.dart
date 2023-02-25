import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/tools/repository/repository.dart';

class AdvertRepository extends Repository {
  @override
  final ext = 'advert/';

  Future<List<Advert>> getAdverts() async {
    return (await getList()).map((e) => Advert.fromJson(e)).toList();
  }

  Future<Advert> getAdvert(String id) async {
    return Advert.fromJson(await getOne(id));
  }

  Future<Advert> addAdvert(Advert advert) async {
    return Advert.fromJson(await create(advert.toJson()));
  }

  Future<bool> updateAdvert(Advert advert) async {
    return await update(advert.toJson(), "/${advert.id}");
  }

  Future<bool> deleteAdvert(String id) async {
    return await delete("/$id");
  }
}
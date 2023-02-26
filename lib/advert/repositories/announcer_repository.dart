import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/tools/repository/repository.dart';

class AnnouncerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "advert/";

  Future<List<Announcer>> getAnnouncerList() async {
    return List<Announcer>.from((await getList(suffix: "announcer/")).map((x) => Announcer.fromJson(x)));
  }

  Future<List<Announcer>> getMyAnnouncer() async {
    return List<Announcer>.from((await getList(suffix: "users/me/announcer")).map((x) => Announcer.fromJson(x)));
  }

  Future<Announcer> getAnnouncer(String id) async {
    return Announcer.fromJson(await getOne("announcer/$id"));
  }

  Future<Announcer> createAnnouncer(Announcer announcer) async {
    return Announcer.fromJson(await create(announcer.toJson(), suffix: "announcer/"));
  }

  Future<bool> updateAnnouncer(Announcer announcer) async {
    return await update(announcer.toJson(), "announcer/${announcer.id}");
  }

  Future<bool> deleteAnnouncer(String announcerId) async {
    return await delete("announcer/$announcerId");
  }
}
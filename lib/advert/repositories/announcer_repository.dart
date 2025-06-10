import 'package:titan/advert/class/announcer.dart';
import 'package:titan/tools/repository/repository.dart';

class AnnouncerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "advert/";

  Future<List<Announcer>> getAllAnnouncer() async {
    return List<Announcer>.from(
      (await getList(suffix: "advertisers")).map((x) => Announcer.fromJson(x)),
    );
  }

  Future<List<Announcer>> getMyAnnouncer() async {
    return List<Announcer>.from(
      (await getList(
        suffix: "me/advertisers",
      )).map((x) => Announcer.fromJson(x)),
    );
  }

  Future<Announcer> getAnnouncer(String id) async {
    return Announcer.fromJson(await getOne("advertisers/$id"));
  }

  Future<Announcer> createAnnouncer(Announcer announcer) async {
    return Announcer.fromJson(
      await create(announcer.toJson(), suffix: "advertisers"),
    );
  }

  Future<bool> updateAnnouncer(Announcer announcer) async {
    return await update(announcer.toJson(), "advertisers/${announcer.id}");
  }

  Future<bool> deleteAnnouncer(String announcerId) async {
    return await delete("advertisers/$announcerId");
  }
}

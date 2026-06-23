import 'package:titan/rplace/class/userInfo.dart';
import 'package:titan/tools/repository/repository.dart';

class UserinfoRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "rplace/";

  Future<UserInfo> getLastPlacedDate() async {
    print("getlastPixel");
    return UserInfo.fromJson(await getOne("last_pixel_date"));
  }
}

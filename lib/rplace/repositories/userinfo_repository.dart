import 'package:myecl/rplace/class/userInfo.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserinfoRepository extends Repository {
  @override
  final ext = "rplace/";

  Future<UserInfo> getLastPlacedDate() async {
    return UserInfo.fromJson(await getOne("last_pixel_date"));
  }
}

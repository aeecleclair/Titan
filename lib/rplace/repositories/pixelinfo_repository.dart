import 'package:myecl/rplace/class/pixelinfo.dart';
import 'package:myecl/tools/repository/repository.dart';

class PixelInfoRepository extends Repository {
  @override
  final ext = "rplace/";

  Future<PixelInfo> getPixelInfo(int x, int y) async {
    return PixelInfo.fromJson(await getOne("pixel_info/$x/$y"));
  }
}

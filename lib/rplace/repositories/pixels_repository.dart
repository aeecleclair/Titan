import 'package:myecl/rplace/class/pixel.dart';
import 'package:myecl/tools/repository/repository.dart';

class PixelRepository extends Repository {
  @override
  final ext = "rplace/";

  Future<List<Pixel>> getPixels() async {
    await connect();
    return List<Pixel>.from(
      (await getList(suffix: "pixels")).map((e) => Pixel.fromJson(e)),
    );
  }

  Future<Pixel> createPixel(Pixel pixel) async {
    return Pixel.fromJson(await create(pixel.toJson(), suffix: "pixels"));
  }
}

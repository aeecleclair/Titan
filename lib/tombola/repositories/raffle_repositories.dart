import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tools/repository/repository.dart';

import 'package:http/http.dart' as http;

class RaffleRepository extends Repository {
  @override
  Future<List<Raffle>> getRaffleList() async {
    return List<Raffle>.from((await getList(suffix: "tombola/raffle")).map((x) => Raffle.fromJson(x)));
  }
}

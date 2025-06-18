import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/class/result.dart';

class ResultRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/results';

  ResultRepository(super.ref);

  Future<List<Result>> getResult() async {
    return List<Result>.from((await getList()).map((e) => Result.fromJson(e)));
  }
}

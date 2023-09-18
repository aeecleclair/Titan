import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/tools/repository/repository.dart';

class LoanerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "loans/";

  Future<List<Loaner>> getLoanerList() async {
    return List<Loaner>.from(
        (await getList(suffix: "loaners/")).map((x) => Loaner.fromJson(x)));
  }

  Future<List<Loaner>> getMyLoaner() async {
    return List<Loaner>.from((await getList(suffix: "users/me/loaners"))
        .map((x) => Loaner.fromJson(x)));
  }

  Future<Loaner> getLoaner(String id) async {
    return Loaner.fromJson(await getOne("loaners/$id"));
  }

  Future<Loaner> createLoaner(Loaner loaner) async {
    return Loaner.fromJson(await create(loaner.toJson(), suffix: "loaners/"));
  }

  Future<bool> updateLoaner(Loaner loaner) async {
    return await update(loaner.toJson(), "loaners/${loaner.id}");
  }

  Future<bool> deleteLoaner(String loanerId) async {
    return await delete("loaners/$loanerId");
  }
}

import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/tools/repository/repository.dart';

class LoanerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "loans/loaners/";

  Future<List<Loaner>> getLoanerList() async {
    return List<Loaner>.from((await getList()).map((x) => Loaner.fromJson(x)));
  }

  Future<Loaner> getLoaner(String id) async {
    return Loaner.fromJson(await getOne(id));
  }

  Future<Loaner> createLoaner(Loaner loaner) async {
    return Loaner.fromJson(await create(loaner.toJson()));
  }

  Future<bool> updateLoaner(Loaner loaner) async {
    return await update(loaner.toJson(), loaner.id);
  }

  Future<bool> deleteLoaner(String loanerId) async {
    return await delete(loanerId);
  }
}
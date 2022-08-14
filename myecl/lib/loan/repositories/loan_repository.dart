import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/tools/repository/repository.dart';

class LoanRepository extends Repository {
  @override
  final ext = "loans/";

  Future<List<Loan>> getLoanListByGroupId(String groupId) async {
    return List<Loan>.from((await getList(suffix: groupId)).map((x) => Loan.fromJson(x)));
  }

  Future<List<Loan>> getLoanListByBorrowerId(String borrowerId) async {
     return List<Loan>.from(
        (await getList(suffix: borrowerId)).map((x) => Loan.fromJson(x)));
  }

  Future<Loan> getLoan(String id) async {
    return Loan.fromJson(await getOne(id));
  }

  Future<Loan> createLoan(Loan loan) async {
    return Loan.fromJson(await create(loan.toJson()));
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(loan.toJson(), loan.id);
  }

  Future<bool> deleteLoan(Loan loan) async {
    return await delete(loan.id);
  }

  Future<List<Loan>> getHistory() async {
    return List<Loan>.from((await getList(suffix: "history")).map((x) => Loan.fromJson(x)));
  }
}

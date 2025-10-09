import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/tools/repository/repository.dart';

class LoanRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "loans/";

  Future<List<Loan>> getLoanListByLoanerId(String loanerId) async {
    return List<Loan>.from(
      (await getList(
        suffix: "loaners/$loanerId/loans?returned=false",
      )).map((x) => Loan.fromJson(x)),
    );
  }

  Future<List<Loan>> getMyLoanList() async {
    return List<Loan>.from(
      (await getList(suffix: "users/me")).map((x) => Loan.fromJson(x)),
    );
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

  Future<bool> deleteLoan(String loanId) async {
    return await delete(loanId);
  }

  Future<bool> extendLoan(Loan loan, int newDate) async {
    return await create({
      "duration": newDate * 24 * 60 * 60,
    }, suffix: "${loan.id}/extend");
  }

  Future<bool> returnLoan(String loanId) async {
    return await create({}, suffix: "$loanId/return");
  }

  Future<List<Loan>> getHistory(String loanerId) async {
    return List<Loan>.from(
      (await getList(
        suffix: "loaners/$loanerId/loans?returned=true",
      )).map((x) => Loan.fromJson(x)),
    );
  }
}

final loanRepositoryProvider = Provider<LoanRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return LoanRepository()..setToken(token);
});

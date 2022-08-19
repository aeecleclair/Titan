import 'dart:convert';

import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/exception.dart';

class LoanRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "loans/";

  Future<List<Loan>> getLoanListByLoanerId(String loanerId) async {
    return List<Loan>.from(
        (await getList(suffix: "loaners/" + loanerId + "/loans"))
            .map((x) => Loan.fromJson(x)));
  }

  Future<List<Loan>> getMyLoanList() async {
    return List<Loan>.from(
        (await getList(suffix: "users/me")).map((x) => Loan.fromJson(x)));
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
    final response = await http.post(
        Uri.parse(host + ext + loan.id + "/extend"),
        headers: headers,
        body: json.encode({"duration": newDate * 24 * 60 * 60}));
    if (response.statusCode == 204) {
      try {
        return true;
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to create item");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to create item");
    }
  }

  Future<bool> returnLoan(String loanId) async {
    final response = await http
        .patch(Uri.parse(host + ext + loanId + "/return"), headers: headers);
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update item");
    }
  }

  Future<List<Loan>> getHistory() async {
    return List<Loan>.from(
        (await getList(suffix: "history")).map((x) => Loan.fromJson(x)));
  }
}

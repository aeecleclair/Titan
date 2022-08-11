import 'dart:convert';

import 'package:myecl/loan/class/loan.dart';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository.dart';

class LoanRepository extends Repository {
  final ext = "loans/";

  Future<List<Loan>> getLoanListByGroupId(String groupId) async {
    final response =
        await http.get(Uri.parse(host + ext + groupId), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<Loan>.from(json.decode(resp));
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load loans");
    }
  }

  Future<List<Loan>> getLoanListByBorrowerId(String borrowerId) async {
    final response =
        await http.get(Uri.parse(host + ext + borrowerId), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<Loan>.from(json.decode(resp));
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load loans");
    }
  }

  Future<Loan> getLoan(String id) async {
    final response = await http.get(
      Uri.parse(host + ext + id),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Loan.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to load loan");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load loan");
    }
  }

  Future<Loan> createLoan(Loan loan) async {
    final response = await http.post(Uri.parse(host + ext),
        headers: headers, body: json.encode(loan));
    if (response.statusCode == 201) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Loan.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to create loan");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to create loan");
    }
  }

  Future<bool> updateLoan(Loan loan) async {
    final response = await http.patch(Uri.parse(host + ext + loan.id),
        headers: headers, body: json.encode(loan));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update loan");
    }
  }

  Future<bool> deleteLoan(Loan loan) async {
    final response =
        await http.delete(Uri.parse(host + ext + loan.id), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to delete loan");
    }
  }

  Future<List<Loan>> getHistory() async {
    final response =
        await http.get(Uri.parse(host + ext + "history"), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<Loan>.from(json.decode(resp));
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load loans");
    }
  }
}

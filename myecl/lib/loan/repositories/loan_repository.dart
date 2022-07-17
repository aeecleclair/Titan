import 'dart:convert';

import 'package:myecl/loan/class/loan.dart';
import 'package:http/http.dart' as http;

class LoanRepository {
  final host = "http://10.0.2.2:8000/";
  final ext = "loans/";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<List<Loan>> getLoanList() async {
    final response =
        await http.get(Uri.parse(host + ext), headers: headers);
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return List<Loan>.from(json.decode(resp));
    } else {
      throw Exception("Failed to load loan list");
    }
  }

  Future<Loan> getLoan(String id) async {
    final response = await http.get(
      Uri.parse(host + ext + id),
      headers: headers,
    );
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return Loan.fromJson(json.decode(resp));
    } else {
      throw Exception("Failed to load loan");
    }
  }

  Future<bool> createLoan(Loan loan) async {
    final response = await http.post(Uri.parse(host + ext),
        headers: headers, body: json.encode(loan));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create loan");
    }
  }

  Future<bool> updateLoan(Loan loan) async {
    final response = await http.patch(Uri.parse(host + ext + loan.id),
        headers: headers, body: json.encode(loan));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update loan");
    }
  }

  Future<bool> deleteLoan(Loan loan) async {
    final response = await http.delete(Uri.parse(host + ext + loan.id),
        headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete loan");
    }
  }

  Future<List<Loan>> getHistory() async {
    final response = await http.get(Uri.parse(host + ext + "history"),
        headers: headers);
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return List<Loan>.from(json.decode(resp));
    } else {
      throw Exception("Failed to load loan history");
    }
  }
}
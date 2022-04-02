import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myecl/user/providers/parser.dart';
import '../models/association.dart';
import '../models/user.dart';

class AssociationProvider {

  static const url = '/associations';


  Future<List<Association>> getAssociations() async {
    var resp = await http.get(Uri.parse(url),
        headers: {'Content-Type': 'application/json'});
    return parseAssociations(resp.body);
  }

  Future<int> createAssociation(Association association) async {
    var resp = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(association.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> editAssociation(Association association) async {
    var resp = await http.put(
      Uri.parse('$url/${association.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(association.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> deleteAssociation(String id) async {
    var resp = await http.delete(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }

  Future<Association> getAssociation(String id) async {
    var resp = await http.get(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return parseAssociation(resp.body);
  }

  Future<List<User>> getAssociationUsers(String id) async {
    var resp = await http.get(
      Uri.parse('$url/$id/users'),
      headers: {'Content-Type': 'application/json'},
    );
    return parseUsers(resp.body);
  }

  Future<int> addUserToAssociation(String id, String userId) async {
    var resp = await http.post(
      Uri.parse('$url/$id/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }

  Future<int> removeUserFromAssociation(String id, String userId) async {
    var resp = await http.delete(
      Uri.parse('$url/$id/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }

  Future<int> addAdminToAssociation(String id, String userId) async {
    var resp = await http.post(
      Uri.parse('$url/$id/admins/$userId'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }

  Future<int> removeAdminFromAssociation(String id, String userId) async {
    var resp = await http.delete(
      Uri.parse('$url/$id/admins/$userId'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }
}
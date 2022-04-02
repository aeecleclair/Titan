import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/user/providers/parser.dart';

import '../models/user.dart';

class UserProvider {

  static const url = '/users';


  Future<User> getUser(String id) async {
    var resp = await http.get(Uri.parse('$url/$id'),
        headers: {'Content-Type': 'application/json'});
    return parseUser(resp.body);
  }

  Future<List<User>> getUsers() async {
    var resp = await http.get(Uri.parse(url),
        headers: {'Content-Type': 'application/json'});
    return parseUsers(resp.body);
  }

  Future<int> createUser(User user) async {
    var resp = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> editUser(User user) async {
    var resp = await http.put(
      Uri.parse('$url/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    return resp.statusCode;
  }

  Future<int> deleteUser(String id) async {
    var resp = await http.delete(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return resp.statusCode;
  }


  // ! cash n'est pas dans le model User
  Future<double> getUserCash(String id) async {
  }

  Future<int> createUserCash(String id, double cash) async {
  }

  Future<int> deleteUserCash(String id) async {
  }

}
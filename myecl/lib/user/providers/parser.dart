import 'dart:convert';

import '../models/association.dart';
import '../models/user.dart';

Association parseAssociation(String resp) {
  var jsonData = json.decode(resp);
  return Association.fromJson(jsonData);
}

List<Association> parseAssociations(String resp) {
  final jsonData = json.decode(resp);
  return (jsonData as List).map((data) => Association.fromJson(data)).toList();
}


List<User> parseUsers(String resp) {
  final jsonData = json.decode(resp);
  return (jsonData as List).map((data) => User.fromJson(data)).toList();
}

User parseUser(String resp) {
  var jsonData = json.decode(resp);
  return User.fromJson(jsonData);
}

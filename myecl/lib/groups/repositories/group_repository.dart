import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/groups/class/group.dart';

class GroupRepository {
  final host = "http://10.0.2.2:8000/";
  final ext = "groups/";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<List<Group>> getAllGroups() async {
    final response =
        await http.get(Uri.parse(host + ext), headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.map<Group>((json) => Group.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load groups');
    }
  }

  Future<Group> getGroup(String groupId) async {
    final response =
        await http.get(Uri.parse(host + ext + groupId), headers: headers);
    if (response.statusCode == 200) {
      return Group.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load group");
    }
  }

  Future<bool> deleteGroup(String groupId) async {
    final response = await http.delete(Uri.parse(host + ext + groupId),
        headers: headers);
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Failed to delete groups");
    }
  }

  Future<bool> updateGroup(Group group) async {
    final response = await http.patch(Uri.parse(host + ext + group.id),
        headers: headers, body: json.encode(group.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update groups");
    }
  }

  Future<bool> createGroup(Group group) async {
    final response = await http.post(Uri.parse(host + ext),
        headers: headers, body: json.encode(group.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create groups");
    }
  }
  // TODO: POST /groups/membership
}
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myecl/groups/class/group.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository.dart';

class GroupRepository extends Repository {
  final ext = "groups/";

  Future<List<Group>> getAllGroups() async {
    final response = await http.get(Uri.parse(host + ext), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<Group>.from(json.decode(resp));
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load groups");
    }
  }

  Future<Group> getGroup(String groupId) async {
    final response =
        await http.get(Uri.parse(host + ext + groupId), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Group.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to load group");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load group");
    }
  }

  Future<bool> deleteGroup(String groupId) async {
    final response =
        await http.delete(Uri.parse(host + ext + groupId), headers: headers);
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to delete group");
    }
  }

  Future<bool> updateGroup(Group group) async {
    final response = await http.patch(Uri.parse(host + ext + group.id),
        headers: headers, body: json.encode(group.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update group");
    }
  }

  Future<Group> createGroup(Group group) async {
    final response = await http.post(Uri.parse(host + ext),
        headers: headers, body: json.encode(group.toJson()));
    if (response.statusCode == 201) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Group.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to create group");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to create group");
    }
  }
  // TODO: POST /groups/membership
}

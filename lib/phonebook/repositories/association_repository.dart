import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/exception.dart';

class AssociationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/association/";

  Future<List<Association>> getAssociationList() async {
    return List<Association>.from(
        (await getList()).map((x) => Association.fromJSON(x)));
  }

  Future<Association> getAssociation(String associationId) async {
    return Association.fromJSON(await getOne(associationId));
  }

  Future<bool> deleteAssociation(String associationId) async {
    return await delete(associationId);
  }

  Future<bool> updateAssociation(Association association) async {
    return await update(association.toJSON(), association.id);
  }

Future<Association> createAssociation(Association association) async {
    return Association.fromJSON(await create(association.toJSON()));
  }

  Future<bool> addMember(Association association, SimpleUser user) async {
    await create({"user_id": user.id, "association_id": association.id},
        suffix: "membership");
    return true;
  }

  Future<bool> deleteMember(Association association, SimpleUser user) async {
    final response = await http.delete(
        Uri.parse("$host${ext}membership"),
        headers: headers,
        body: json.encode({"user_id": user.id, "association_id": association.id}));
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update item");
    }
  }
}

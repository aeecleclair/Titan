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

  Future<List<Association>> getAssociationList([String? filter]) async {
    String suffix = "";
    if (filter != null) {
      suffix = "?filter=$filter";
    }
    return List<Association>.from(
        (await getList(suffix: suffix)).map((x) => Association.fromJSON(x)));
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
}

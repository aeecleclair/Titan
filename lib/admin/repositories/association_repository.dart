import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "associations/";

  Future<List<Association>> getAssociationList() async {
    return List<Association>.from(
      (await getList()).map((x) => Association.fromJson(x)),
    );
  }

  Future<Association> getMyAssociation() async {
    return Association.fromJson(await getOne("", suffix: "me"));
  }

  Future<bool> deleteAssociation(String associationId) async {
    return await delete(associationId);
  }

  Future<bool> updateAssociation(Association association) async {
    return await update(association.toJson(), association.id);
  }

  Future<Association> createAssociation(Association association) async {
    return Association.fromJson(await create(association.toJson()));
  }
}

final associationRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return AssociationRepository()..setToken(token);
});

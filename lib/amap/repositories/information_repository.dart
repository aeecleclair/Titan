import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/information.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';

class InformationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/information";

  InformationRepository(super.ref);

  Future<Information> getInformation() async {
    return Information.fromJson(await getOne(""));
  }

  Future<Information> createInformation(Information information) async {
    return Information.fromJson(await create(information.toJson()));
  }

  Future<bool> updateInformation(Information information) async {
    return await update(information.toJson(), "");
  }

  Future<bool> deleteInformation(String id) async {
    return await delete(id);
  }
}

final informationRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return InformationRepository(ref)..setToken(token);
});

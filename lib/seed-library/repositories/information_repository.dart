import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/seed-library/class/information.dart';
import 'package:titan/tools/repository/repository.dart';

class InformationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "seed_library/information";

  Future<Information> getInformation() async {
    return Information.fromJson(await getOne(""));
  }

  Future<bool> updateInformation(Information information) async {
    return await update(information.toJson(), "");
  }
}

final informationRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return InformationRepository()..setToken(token);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/seed-library/class/seed_deposit.dart';
import 'package:myecl/tools/repository/repository.dart';

class SeedDepositRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "calendar/seedDeposits/";

  Future<List<SeedDeposit>> getAllSeedDeposit() async {
    return List<SeedDeposit>.from(
        (await getList()).map((x) => SeedDeposit.fromJson(x)));
  }

  Future<List<SeedDeposit>> getConfirmedSeedDepositList() async {
    return List<SeedDeposit>.from(
      (await getList(suffix: "confirmed")).map((x) => SeedDeposit.fromJson(x)),
    );
  }

  Future<List<SeedDeposit>> getUserSeedDepositList(String id) async {
    return List<SeedDeposit>.from(
      (await getList(suffix: "user/$id")).map((x) => SeedDeposit.fromJson(x)),
    );
  }

  Future<bool> confirmSeedDeposit(SeedDeposit seedDeposit) async {
    return await update(
      {},
      seedDeposit.id,
      suffix: '/reply/${seedDeposit.decision.toString().split('.')[1]}',
    );
  }

  Future<SeedDeposit> getSeedDeposit(String id) async {
    return SeedDeposit.fromJson(await getOne(id));
  }

  Future<SeedDeposit> createSeedDeposit(SeedDeposit seedDeposit) async {
    return SeedDeposit.fromJson(await create(seedDeposit.toJson()));
  }

  Future<bool> updateSeedDeposit(SeedDeposit seedDeposit) async {
    return await update(seedDeposit.toJson(), seedDeposit.id);
  }

  Future<bool> deleteSeedDeposit(String id) async {
    return await delete(id);
  }
}

final seedDepositRepositoryProvider = Provider<SeedDepositRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return SeedDepositRepository()..setToken(token);
});

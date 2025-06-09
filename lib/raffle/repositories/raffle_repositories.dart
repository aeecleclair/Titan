import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/raffle/class/raffle.dart';
import 'package:myecl/tools/repository/repository.dart';

class RaffleRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/raffles";

  RaffleRepository(super.ref);

  Future<List<Raffle>> getRaffleList() async {
    return List<Raffle>.from((await getList()).map((x) => Raffle.fromJson(x)));
  }

  Future<Raffle> getRaffle(String raffleId) async {
    return Raffle.fromJson(await getOne(raffleId, suffix: "/items"));
  }

  Future<Raffle> createRaffle(Raffle raffle) async {
    return Raffle.fromJson(await create(raffle.toJson()));
  }

  Future<bool> updateRaffle(Raffle raffle) async {
    return await update(raffle.toJson(), "/${raffle.id}");
  }

  Future<bool> deleteRaffle(String raffleId) async {
    return await delete("/$raffleId");
  }

  Future<bool> openRaffle(Raffle raffle) async {
    return await update(raffle.toJson(), "/${raffle.id}", suffix: "/open");
  }

  Future<bool> lockRaffle(Raffle raffle) async {
    return await update(raffle.toJson(), "/${raffle.id}", suffix: "/lock");
  }
}

final raffleRepositoryProvider = Provider<RaffleRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return RaffleRepository(ref)..setToken(token);
});

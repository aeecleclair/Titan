import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/repositories/raffle_repositories.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RaffleListNotifier extends ListNotifier<Raffle> {
  final RaffleRepository _rafflerepository = RaffleRepository();
  RaffleListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _rafflerepository.setToken(token);
  }

  Future<AsyncValue<List<Raffle>>> loadRaffleList() async {
    // return await loadList(
    //     () async => _rafflerepository.getRaffleList(raffleId));
    return state = AsyncData([
      Raffle(id: '1', name: 'Tombola Soli Sida', startDate: DateTime.now().subtract(Duration(days: 15)), groupId: '', endDate: DateTime.now().add(Duration(days: 2)),description: "Ceci est la description de la tombola soli, c'est un test. Je le fais long pour tester plusieurs lignes mais le problème est que je manque un peu d'inspiration mais pas vraiment en faite. Bon voilà ca devrait suffire je l'espère" ),
      Raffle(id: '2', name: 'Tombola Test', startDate: DateTime.now().subtract(Duration(days: 1)), groupId: '', endDate: DateTime.now().add(Duration(days: 20)), ),
      Raffle(id: 'azertyuiop', name: 'Tombola Test2', startDate: DateTime.now().add(Duration(days: 10)), groupId: '', endDate: DateTime.now().add(Duration(days: 32)),),
    ]);
  }
}

final raffleListProvider =
    StateNotifierProvider<RaffleListNotifier, AsyncValue<List<Raffle>>>((ref) {
  final token = ref.watch(tokenProvider);
  RaffleListNotifier notifier = RaffleListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadRaffleList();
  });
  return notifier;
});

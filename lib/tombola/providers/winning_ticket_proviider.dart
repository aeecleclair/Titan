import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/repositories/lots_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class WinningTicketNotifier extends ListNotifier<Ticket> {
  final LotRepository _lotRepository = LotRepository();
  WinningTicketNotifier({required String token}) : super(const AsyncLoading()) {
    _lotRepository.setToken(token);
  }

  Future<AsyncValue<List<Ticket>>> drawLot(Lot lot) async {
    return await loadList(() => _lotRepository.drawLot(lot));
  }
}

final lotProvider =
    StateNotifierProvider<WinningTicketNotifier, AsyncValue<List<Ticket>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  return WinningTicketNotifier(token: token);
});

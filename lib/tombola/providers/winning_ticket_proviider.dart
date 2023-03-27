import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/repositories/lots_repository.dart';

class WinningTicketNotifier extends StateNotifier<Ticket> {
  final LotRepository _lotRepository = LotRepository();
  WinningTicketNotifier({required String token}) : super(Ticket.empty()) {
    _lotRepository.setToken(token);
  }

  Future<Ticket> drawLot() async {
    return await _lotRepository.drawLot(state).then((value) => value);
  }
}

final lotProvider = StateNotifierProvider<WinningTicketNotifier, Ticket>((ref) {
  final token = ref.watch(tokenProvider);
  return WinningTicketNotifier(token: token);
});

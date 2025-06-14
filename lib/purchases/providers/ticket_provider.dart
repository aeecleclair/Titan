import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/purchases/class/ticket.dart';
import 'package:titan/purchases/repositories/user_information_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class TicketNotifier extends SingleNotifier<Ticket> {
  final UserInformationRepository ticketRepository =
      UserInformationRepository();
  TicketNotifier({required String token}) : super(const AsyncValue.loading()) {
    ticketRepository.setToken(token);
  }

  void setTicket(Ticket i) {
    state = AsyncValue.data(i);
  }

  Future<AsyncValue<Ticket>> loadTicketSecret() async {
    state.whenData((ticket) async {
      return await load(() => ticketRepository.getTicketQrCodeSecret(ticket));
    });
    return state;
  }
}

final ticketProvider =
    StateNotifierProvider<TicketNotifier, AsyncValue<Ticket>>((ref) {
      final token = ref.watch(tokenProvider);
      TicketNotifier notifier = TicketNotifier(token: token);
      return notifier;
    });

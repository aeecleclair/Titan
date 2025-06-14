import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/purchases/repositories/user_information_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class TicketNotifier extends SingleNotifier<Ticket> {
  final UserInformationRepository ticketRepository;
  TicketNotifier({required this.ticketRepository})
    : super(const AsyncValue.loading());

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
      final userInformationRepository = ref.watch(
        userInformationRepositoryProvider,
      );
      TicketNotifier notifier = TicketNotifier(
        ticketRepository: userInformationRepository,
      );
      return notifier;
    });

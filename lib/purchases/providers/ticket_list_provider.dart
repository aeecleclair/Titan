import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/purchases/repositories/scanner_repository.dart';
import 'package:myecl/purchases/repositories/user_information_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class TicketListNotifier extends ListNotifier<Ticket> {
  final UserInformationRepository ticketRepository;
  final ScannerRepository scannerRepository;
  TicketListNotifier({
    required this.ticketRepository,
    required this.scannerRepository,
  }) : super(const AsyncValue.loading());

  Future<AsyncValue<List<Ticket>>> loadTickets() async {
    return await loadList(ticketRepository.getTicketList);
  }

  Future<bool> consumeTicket(
    String sellerId,
    Ticket ticket,
    String generatorId,
    String tag,
  ) async {
    return await update(
      (Ticket fakeTicket) =>
          scannerRepository.consumeTicket(sellerId, ticket, generatorId, tag),
      (tickets, ticket) {
        List<String> tags = ticket.tags;
        tags.add(tag);
        return tickets
          ..[tickets.indexWhere((g) => g.id == ticket.id)] = ticket.copyWith(
            tags: tags,
            scanLeft: ticket.scanLeft - 1,
          );
      },
      ticket,
    );
  }
}

final ticketListProvider =
    StateNotifierProvider<TicketListNotifier, AsyncValue<List<Ticket>>>((ref) {
      final userInformationRepository = ref.watch(
        userInformationRepositoryProvider,
      );
      final scannerRepository = ScannerRepository(ref);
      TicketListNotifier notifier = TicketListNotifier(
        ticketRepository: userInformationRepository,
        scannerRepository: scannerRepository,
      );
      notifier.loadTickets();
      return notifier;
    });

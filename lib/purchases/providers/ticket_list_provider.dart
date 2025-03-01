import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class TicketListNotifier extends ListNotifier2<Ticket> {
  final Openapi ticketRepository;
  TicketListNotifier({required this.ticketRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Ticket>>> loadTickets() async {
    return await loadList(ticketRepository.cdrUsersMeTicketsGet);
  }

  // Need to go back to it
  Future<bool> consumeTicket(
    String sellerId,
    Ticket ticket,
    String generatorId,
    String tag,
  ) async {
    return await update(
      () => ticketRepository
          .cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretPatch(
        sellerId: sellerId,
        productId: ticket.productId,
        generatorId: generatorId,
        secret: ticket.secret,
        body: TicketScan(
          tag: tag,
        ),
      ),
      (tickets, ticket) {
        List<String> tags = ticket.tags;
        tags.add(tag);
        return tickets
          ..[tickets.indexWhere((g) => g.id == ticket.id)] =
              ticket.copyWith(tags: tags, scanLeft: ticket.scanLeft - 1);
      },
      ticket,
    );
  }
}

final ticketListProvider =
    StateNotifierProvider<TicketListNotifier, AsyncValue<List<Ticket>>>((ref) {
  final ticketRepository = ref.watch(repositoryProvider);
  TicketListNotifier notifier =
      TicketListNotifier(ticketRepository: ticketRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadTickets();
  });
  return notifier;
});

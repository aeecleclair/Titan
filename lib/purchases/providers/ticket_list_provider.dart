import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class TicketListNotifier extends ListNotifierAPI<Ticket> {
  final Openapi ticketRepository;
  TicketListNotifier({required this.ticketRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Ticket>>> loadTickets() async {
    return await loadList(ticketRepository.cdrUsersMeTicketsGet);
  }

  // Need to go back to it
  Future<bool> consumeTicket(
    String sellerId,
    String productId,
    String secret,
    Ticket ticket,
    String generatorId,
    String tag,
  ) async {
    return await update(
      () => ticketRepository
          .cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretPatch(
        sellerId: sellerId,
        productId: productId,
        generatorId: generatorId,
        secret: secret,
        body: TicketScan(
          tag: tag,
        ),
      ),
      (tickets) => tickets.id,
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

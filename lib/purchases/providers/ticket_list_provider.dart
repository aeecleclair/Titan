import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class TicketListNotifier
    extends ListNotifierAPI<AppModulesCdrSchemasCdrTicket> {
  Openapi get ticketRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AppModulesCdrSchemasCdrTicket>> build() {
    loadTickets();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AppModulesCdrSchemasCdrTicket>>> loadTickets() async {
    return await loadList(ticketRepository.cdrUsersMeTicketsGet);
  }

  // Need to go back to it
  Future<bool> consumeTicket(
    String sellerId,
    String productId,
    AppModulesCdrSchemasCdrTicket ticket,
    String generatorId,
    String tag,
    String secret,
  ) async {
    return await update(
      () => ticketRepository
          .cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretPatch(
            sellerId: sellerId,
            productId: productId,
            generatorId: generatorId,
            secret: secret,
            body: TicketScan(tag: tag),
          ),
      (ticket) => ticket.id,
      ticket.copyWith(
        tags: "${ticket.tags}, $tag",
        scanLeft: ticket.scanLeft - 1,
      ),
    );
  }
}

final ticketListProvider =
    NotifierProvider<
      TicketListNotifier,
      AsyncValue<List<AppModulesCdrSchemasCdrTicket>>
    >(TicketListNotifier.new);

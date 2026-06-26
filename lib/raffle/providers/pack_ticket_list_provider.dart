import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class PackTicketsListNotifier extends ListNotifierAPI<PackTicketSimple> {
  Openapi get packTicketsRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<PackTicketSimple>> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<PackTicketSimple>>> loadPackTicketList(
    String raffleId,
  ) async {
    return await loadList(
      () async => packTicketsRepository.tombolaRafflesRaffleIdPackTicketsGet(
        raffleId: raffleId,
      ),
    );
  }

  Future<bool> addPackTicket(PackTicketBase packTicket) async {
    return await add(
      () => packTicketsRepository.tombolaPackTicketsPost(body: packTicket),
      packTicket,
    );
  }

  Future<bool> updatePackTicket(PackTicketSimple packTicket) async {
    return update(
      () => packTicketsRepository.tombolaPackTicketsPackticketIdPatch(
        packticketId: packTicket.id,
        body: PackTicketEdit(
          price: packTicket.price,
          packSize: packTicket.packSize,
          raffleId: packTicket.raffleId,
        ),
      ),
      (packTicket) => packTicket.id,
      packTicket,
    );
  }

  Future<bool> deletePackTicket(PackTicketSimple packTicket) async {
    return await delete(
      () => packTicketsRepository.tombolaPackTicketsPackticketIdDelete(
        packticketId: packTicket.id,
      ),
      (packTicket) => packTicket.id,
      packTicket.id,
    );
  }
}

final packTicketListProvider =
    NotifierProvider<
      PackTicketsListNotifier,
      AsyncValue<List<PackTicketSimple>>
    >(() => PackTicketsListNotifier());

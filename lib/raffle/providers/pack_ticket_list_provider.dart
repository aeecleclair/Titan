import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/raffle/adapters/pack_ticket.dart';

class PackTicketsListNotifier extends ListNotifierAPI<PackTicketSimple> {
  final Openapi packTicketsRepository;
  PackTicketsListNotifier({required this.packTicketsRepository})
      : super(const AsyncValue.loading());

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
        body: packTicket.toPackTicketEdit(),
      ),
      (packTicket) => packTicket.id,
      packTicket,
    );
  }

  Future<bool> deletePackTicket(String packTicketId) async {
    return await delete(
      () => packTicketsRepository.tombolaPackTicketsPackticketIdDelete(
        packticketId: packTicketId,
      ),
      (p) => p.id,
      packTicketId,
    );
  }
}

final packTicketListProvider = StateNotifierProvider.family<
    PackTicketsListNotifier,
    AsyncValue<List<PackTicketSimple>>,
    String>((ref, raffleId) {
  final packTicketsRepository = ref.watch(repositoryProvider);
  final notifier =
      PackTicketsListNotifier(packTicketsRepository: packTicketsRepository);
  notifier.loadPackTicketList(raffleId);

  return notifier;
});

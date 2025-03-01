import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';

class PackTicketsListNotifier extends ListNotifier2<PackTicketSimple> {
  final Openapi packTicketsRepository;
  PackTicketsListNotifier({required this.packTicketsRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<PackTicketSimple>>> loadPackTicketList(
      String raffleId) async {
    return await loadList(
      () async => packTicketsRepository.tombolaRafflesRaffleIdPackTicketsGet(
          raffleId: raffleId),
    );
  }

  Future<bool> addPackTicket(PackTicketBase packTicket) async {
    return await add(
        () => packTicketsRepository.tombolaPackTicketsPost(body: packTicket),
        packTicket);
  }

  Future<bool> updatePackTicket(PackTicketSimple packTicket) async {
    return update(
      () => packTicketsRepository.tombolaPackTicketsPackticketIdPatch(
          packticketId: packTicket.id,
          body: PackTicketEdit(
              price: packTicket.price,
              packSize: packTicket.packSize,
              raffleId: packTicket.raffleId)),
      (packTickets, t) =>
          packTickets..[packTickets.indexWhere((e) => e.id == t.id)] = t,
      packTicket,
    );
  }

  Future<bool> deletePackTicket(PackTicketSimple packTicket) async {
    return await delete(
      () => packTicketsRepository.tombolaPackTicketsPackticketIdDelete(
          packticketId: packTicket.id),
      (packTickets, t) => packTickets..removeWhere((e) => e.id == t.id),
      packTicket,
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

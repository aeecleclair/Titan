import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/raffle/providers/raffle_id_provider.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PackTicketsListNotifier extends ListNotifier2<PackTicketSimple> {
  final Openapi packTicketsRepository;
  PackTicketsListNotifier({required this.packTicketsRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<PackTicketSimple>>> loadPackTicketList(
      String raffleId) async {
    return await loadList(() async => packTicketsRepository
        .tombolaRafflesRaffleIdPackTicketsGet(raffleId: raffleId));
  }

  Future<bool> addPackTicket(PackTicketSimple packTicket) async {
    return add(
        (packTicket) async => packTicketsRepository.tombolaPackTicketsPost(
                body: PackTicketBase(
              price: packTicket.price,
              packSize: packTicket.packSize,
              raffleId: packTicket.raffleId,
            )),
        packTicket);
  }

  Future<bool> updatePackTicket(PackTicketSimple packTicket) async {
    return update(
        (packTicket) async =>
            packTicketsRepository.tombolaPackTicketsPackticketIdPatch(
                packticketId: packTicket.id,
                body: PackTicketEdit(
                  raffleId: packTicket.raffleId,
                  price: packTicket.price,
                  packSize: packTicket.packSize,
                )),
        (packTickets, t) =>
            packTickets..[packTickets.indexWhere((e) => e.id == t.id)] = t,
        packTicket);
  }

  Future<bool> deletePackTicket(PackTicketSimple packTicket) async {
    return delete(
      (packTicketId) async => packTicketsRepository
          .tombolaPackTicketsPackticketIdDelete(packticketId: packTicketId),
      (packTickets, t) => packTickets..removeWhere((e) => e.id == t.id),
      packTicket.id,
      packTicket,
    );
  }
}

final packTicketListProvider = StateNotifierProvider<PackTicketsListNotifier,
    AsyncValue<List<PackTicketSimple>>>((ref) {
  final packTicketsRepository = ref.watch(repositoryProvider);
  final notifier =
      PackTicketsListNotifier(packTicketsRepository: packTicketsRepository);
  tokenExpireWrapperAuth(ref, () async {
    final raffleId = ref.watch(raffleIdProvider);
    if (raffleId != RaffleComplete.fromJson({}).id) {
      notifier.loadPackTicketList(raffleId);
    }
  });
  return notifier;
});

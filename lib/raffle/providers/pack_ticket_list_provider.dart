import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/class/pack_ticket.dart';
import 'package:titan/raffle/providers/raffle_id_provider.dart';
import 'package:titan/raffle/repositories/raffle_detail_repository.dart';
import 'package:titan/raffle/repositories/pack_ticket_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class PackTicketsListNotifier extends ListNotifier<PackTicket> {
  final PackTicketRepository _packTicketsRepository = PackTicketRepository();
  final RaffleDetailRepository _raffleDetailRepository =
      RaffleDetailRepository();
  late String raffleId;
  PackTicketsListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    _packTicketsRepository.setToken(token);
    _raffleDetailRepository.setToken(token);
  }

  void setRaffleId(String id) {
    raffleId = id;
  }

  Future<AsyncValue<List<PackTicket>>> loadPackTicketList() async {
    return await loadList(
      () async => _raffleDetailRepository.getPackTicketListFromRaffle(raffleId),
    );
  }

  Future<bool> addPackTicket(PackTicket packTicket) async {
    return add(_packTicketsRepository.createPackTicket, packTicket);
  }

  Future<bool> deletePackTicket(PackTicket packTicket) async {
    return delete(
      _packTicketsRepository.deletePackTicket,
      (packTickets, t) => packTickets..removeWhere((e) => e.id == t.id),
      packTicket.id,
      packTicket,
    );
  }

  Future<bool> updatePackTicket(PackTicket packTicket) async {
    return update(
      _packTicketsRepository.updatePackTicket,
      (packTickets, t) =>
          packTickets..[packTickets.indexWhere((e) => e.id == t.id)] = t,
      packTicket,
    );
  }
}

final packTicketListProvider =
    StateNotifierProvider<
      PackTicketsListNotifier,
      AsyncValue<List<PackTicket>>
    >((ref) {
      final token = ref.watch(tokenProvider);
      final notifier = PackTicketsListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        final raffleId = ref.watch(raffleIdProvider);
        if (raffleId != Raffle.empty().id) {
          notifier.setRaffleId(raffleId);
          notifier.loadPackTicketList();
        }
      });
      return notifier;
    });

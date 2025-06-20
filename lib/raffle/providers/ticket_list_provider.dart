import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/raffle/class/raffle.dart';
import 'package:myecl/raffle/class/tickets.dart';
import 'package:myecl/raffle/providers/raffle_id_provider.dart';
import 'package:myecl/raffle/repositories/raffle_detail_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class TicketsListNotifier extends ListNotifier<Ticket> {
  final RaffleDetailRepository _raffleDetailRepository;
  late String raffleId;
  TicketsListNotifier(this._raffleDetailRepository)
    : super(const AsyncValue.loading());

  void setId(String id) {
    raffleId = id;
  }

  Future<AsyncValue<List<Ticket>>> loadTicketList() async {
    return await loadList(
      () async => _raffleDetailRepository.getTicketListFromRaffle(raffleId),
    );
  }
}

final ticketsListProvider =
    StateNotifierProvider<TicketsListNotifier, AsyncValue<List<Ticket>>>((ref) {
      final raffleDetailRepository = RaffleDetailRepository(ref);
      final notifier = TicketsListNotifier(raffleDetailRepository);
      final raffleId = ref.watch(raffleIdProvider);
      if (raffleId != Raffle.empty().id) {
        notifier.setId(raffleId);
        notifier.loadTicketList();
      }
      return notifier;
    });

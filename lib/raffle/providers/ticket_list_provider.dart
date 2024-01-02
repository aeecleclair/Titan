import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/raffle/providers/raffle_id_provider.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';

class TicketsListNotifier extends ListNotifier2<TicketComplete> {
  final Openapi raffleDetailRepository;
  TicketsListNotifier({required this.raffleDetailRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<TicketComplete>>> loadTicketList(
      String raffleId) async {
    return await loadList(() async => raffleDetailRepository
        .tombolaRafflesRaffleIdTicketsGet(raffleId: raffleId));
  }
}

final ticketsListProvider = StateNotifierProvider<TicketsListNotifier,
    AsyncValue<List<TicketComplete>>>((ref) {
  final raffleDetailRepository = ref.watch(repositoryProvider);
  final notifier =
      TicketsListNotifier(raffleDetailRepository: raffleDetailRepository);
  final raffleId = ref.watch(raffleIdProvider);
  if (raffleId != TicketComplete.fromJson({}).id) {
    notifier.loadTicketList(raffleId);
  }
  return notifier;
});

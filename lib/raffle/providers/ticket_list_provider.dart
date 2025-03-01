import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';

class TicketsListNotifier extends ListNotifier2<TicketComplete> {
  final Openapi raffleDetailRepository;
  TicketsListNotifier({required this.raffleDetailRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<TicketComplete>>> loadTicketList(
      String raffleId) async {
    return await loadList(
      () async => raffleDetailRepository.tombolaRafflesRaffleIdTicketsGet(
          raffleId: raffleId),
    );
  }
}

final ticketsListProvider = StateNotifierProvider.family<TicketsListNotifier,
    AsyncValue<List<TicketComplete>>, String>((ref, raffleId) {
  final raffleDetailRepository = ref.watch(repositoryProvider);
  final notifier =
      TicketsListNotifier(raffleDetailRepository: raffleDetailRepository);

  notifier.loadTicketList(raffleId);

  return notifier;
});

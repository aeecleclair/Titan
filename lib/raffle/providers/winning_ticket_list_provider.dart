import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/raffle/providers/ticket_list_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/repository/repository.dart';

class WinningTicketNotifier extends ListNotifier<TicketComplete> {
  final Openapi prizeRepository;
  WinningTicketNotifier({required this.prizeRepository})
      : super(const AsyncValue.loading());

  void setData(List<TicketComplete> tickets) {
    state = AsyncValue.data(tickets);
  }

  Future<AsyncValue<List<TicketComplete>>> drawPrize(PrizeSimple prize) async {
    final drawnList =
        await prizeRepository.tombolaPrizesPrizeIdDrawPost(prizeId: prize.id);
    if (drawnList.isSuccessful) {
      state.when(
        data: (list) {
          state = AsyncValue.data(list + drawnList.body!);
        },
        error: (e, s) {},
        loading: () {
          state = AsyncValue.data(drawnList.body!);
        },
      );
      return AsyncData(drawnList.body!);
    } else {
      return AsyncError(drawnList.error!, StackTrace.current);
    }
  }
}

final winningTicketListProvider = StateNotifierProvider.family<
    WinningTicketNotifier,
    AsyncValue<List<TicketComplete>>,
    String>((ref, userId) {
  final prizeRepository = ref.watch(repositoryProvider);
  WinningTicketNotifier notifier =
      WinningTicketNotifier(prizeRepository: prizeRepository);
  final ticketFromRaffle = ref.watch(ticketsListProvider(userId));
  final winningTickets = ticketFromRaffle.maybeWhen<List<TicketComplete>>(
    data: (data) => data.where((element) => element.prize != null).toList(),
    orElse: () => [],
  );
  notifier.setData(winningTickets);
  return notifier;
});

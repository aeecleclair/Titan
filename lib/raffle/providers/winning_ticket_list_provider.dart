import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/raffle/providers/ticket_list_provider.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class WinningTicketNotifier
    extends ListNotifier<AppModulesRaffleSchemasRaffleTicketComplete> {
  Openapi get prizeRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AppModulesRaffleSchemasRaffleTicketComplete>> build() {
    final ticketFromRaffle = ref.watch(ticketsListProvider);
    final winningTickets = ticketFromRaffle
        .maybeWhen<List<AppModulesRaffleSchemasRaffleTicketComplete>>(
          data: (data) =>
              data.where((element) => element.prize != null).toList(),
          orElse: () => [],
        );

    Future.microtask(() => setData(winningTickets));
    return const AsyncValue.loading();
  }

  void setData(List<AppModulesRaffleSchemasRaffleTicketComplete> tickets) {
    state = AsyncValue.data(tickets);
  }

  Future<AsyncValue<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  drawPrize(PrizeSimple prize) async {
    final drawnList = await prizeRepository.tombolaPrizesPrizeIdDrawPost(
      prizeId: prize.id,
    );
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

final winningTicketListProvider =
    NotifierProvider<
      WinningTicketNotifier,
      AsyncValue<List<AppModulesRaffleSchemasRaffleTicketComplete>>
    >(WinningTicketNotifier.new);

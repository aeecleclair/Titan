import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/raffle/providers/raffle_id_provider.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class TicketsListNotifier
    extends ListNotifierAPI<AppModulesRaffleSchemasRaffleTicketComplete> {
  Openapi get raffleDetailRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AppModulesRaffleSchemasRaffleTicketComplete>> build() {
    final currentRaffleId = ref.watch(raffleIdProvider);
    if (currentRaffleId != RaffleComplete.empty().id) {
      loadTicketList(currentRaffleId);
    }
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  loadTicketList(String raffleId) async {
    return await loadList(
      () async => raffleDetailRepository.tombolaRafflesRaffleIdTicketsGet(
        raffleId: raffleId,
      ),
    );
  }
}

final ticketsListProvider =
    NotifierProvider<
      TicketsListNotifier,
      AsyncValue<List<AppModulesRaffleSchemasRaffleTicketComplete>>
    >(TicketsListNotifier.new);

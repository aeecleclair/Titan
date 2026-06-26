import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class UserTicketsNotifier
    extends ListNotifierAPI<AppCoreTicketsSchemasTicketsTicketComplete> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AppCoreTicketsSchemasTicketsTicketComplete>> build() {
    loadUserTickets();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AppCoreTicketsSchemasTicketsTicketComplete>>>
  loadUserTickets() async {
    return await loadList(repository.ticketsUserMeTicketsGet);
  }
}

final userTicketsProvider =
    NotifierProvider<
      UserTicketsNotifier,
      AsyncValue<List<AppCoreTicketsSchemasTicketsTicketComplete>>
    >(UserTicketsNotifier.new);

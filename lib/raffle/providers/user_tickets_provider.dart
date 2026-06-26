import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class UserTicketListNotifier
    extends ListNotifierAPI<AppModulesRaffleSchemasRaffleTicketComplete> {
  Openapi get userTicketsRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AppModulesRaffleSchemasRaffleTicketComplete>> build() {
    final userIdAsync = ref.watch(idProvider);
    userIdAsync.whenData((value) async {
      await loadTicketList(value);
    });
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  loadTicketList(String userId) async {
    return await loadList(
      () => userTicketsRepository.tombolaUsersUserIdTicketsGet(userId: userId),
    );
  }

  Future<bool> buyTicket(PackTicketSimple packTicket) async {
    return addAll(
      (_) async => userTicketsRepository.tombolaTicketsBuyPackIdPost(
        packId: packTicket.id,
      ),
      [],
    );
  }
}

final userTicketListProvider =
    NotifierProvider<
      UserTicketListNotifier,
      AsyncValue<List<AppModulesRaffleSchemasRaffleTicketComplete>>
    >(UserTicketListNotifier.new);

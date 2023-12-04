import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserTicketListNotifier extends ListNotifier2<TicketComplete> {
  final Openapi ticketsRepository;
  UserTicketListNotifier({required this.ticketsRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<TicketComplete>>> loadTicketList(String userId) async {
    return await loadList(() async =>
        ticketsRepository.tombolaUsersUserIdTicketsGet(userId: userId));
  }

  Future<bool> buyTicket(PackTicketSimple packTicket) async {
    return addAll(
        (_) async => ticketsRepository.tombolaTicketsBuyPackIdPost(
            packId: packTicket.id),
        []);
  }
}

final userTicketListProvider = StateNotifierProvider<UserTicketListNotifier,
    AsyncValue<List<TicketComplete>>>((ref) {
  final ticketsRepository = ref.watch(repositoryProvider);
  UserTicketListNotifier notifier =
      UserTicketListNotifier(ticketsRepository: ticketsRepository);
  tokenExpireWrapperAuth(ref, () async {
    final userId = ref.watch(idProvider);
    userId.whenData((value) async {
      await notifier.loadTicketList(value);
    });
  });
  return notifier;
});

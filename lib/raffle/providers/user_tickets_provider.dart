import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';

class UserTicketListNotifier extends ListNotifier2<TicketComplete> {
  final Openapi userTicketsRepository;
  UserTicketListNotifier({required this.userTicketsRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<TicketComplete>>> loadTicketList(String userId) async {
    return await loadList(
      () => userTicketsRepository.tombolaUsersUserIdTicketsGet(userId: userId),
    );
  }

  Future<bool> buyTicket(PackTicketSimple packTicket) async {
    return addAll(
      (_) async => userTicketsRepository.tombolaTicketsBuyPackIdPost(
          packId: packTicket.id),
      [],
    );
  }
}

final userTicketListProvider = StateNotifierProvider.family<
    UserTicketListNotifier,
    AsyncValue<List<TicketComplete>>,
    String>((ref, userId) {
  final userTicketsRepository = ref.watch(repositoryProvider);
  UserTicketListNotifier notifier =
      UserTicketListNotifier(userTicketsRepository: userTicketsRepository);
  notifier.loadTicketList(userId);
  return notifier;
});

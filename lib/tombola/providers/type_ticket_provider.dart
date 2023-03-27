import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/tombola/providers/raffle_id_provider.dart';
import 'package:myecl/tombola/repositories/type_ticket_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class TypeTicketsListNotifier extends ListNotifier<TypeTicket> {
  final TypeTicketRepository _typeTicketsRepository = TypeTicketRepository();
  late String raffleId;
  TypeTicketsListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _typeTicketsRepository.setToken(token);
  }

  void setRaffleId(String id) {
    raffleId = id;
  }

  Future<AsyncValue<List<TypeTicket>>> loadTypeTicketList() async {
    // return await loadList(
    //     () async => _typeTicketsRepository.getTypeTicketsList(raffleId));
    return state = AsyncData([
      TypeTicket(raffleId: "1", price: 1, value: 1, id: "1"),
      TypeTicket(raffleId: "1", price: 2, value: 3, id: "2"),
      TypeTicket(raffleId: "1", price: 5, value: 10, id: "3"),
      TypeTicket(raffleId: "2", price: 10, value: 25, id: "4"),
      TypeTicket(raffleId: "2", price: 20, value: 50, id: "5"),
      TypeTicket(raffleId: "2", price: 1, value: 1, id: "6"),
    ]);
  }

  Future<bool> addTypeTicket(TypeTicket typeTicket) async {
    return add(_typeTicketsRepository.createTypeTicket, typeTicket);
  }

  Future<bool> deleteTypeTicket(TypeTicket typeTicket) async {
    return delete(
      _typeTicketsRepository.deleteTypeTicket,
      (typeTickets, t) =>
          typeTickets..removeWhere((e) => e.value == t.value),
      typeTicket.id,
      typeTicket,
    );
  }

  Future<bool> updateTypeTicket(TypeTicket typeTicket) async {
    return update(
        _typeTicketsRepository.updateTypeTicket,
        (typeTickets, t) => typeTickets
          ..[typeTickets.indexWhere((e) => e.value == t.value)] = t,
        typeTicket);
  }
}

final typeTicketsListProvider = StateNotifierProvider<TypeTicketsListNotifier,
    AsyncValue<List<TypeTicket>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = TypeTicketsListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final raffleId = ref.watch(raffleIdProvider);
    if (raffleId != Raffle.empty().id) {
      notifier.setRaffleId(raffleId);
      notifier.loadTypeTicketList();
    }
  });
  return notifier;
});


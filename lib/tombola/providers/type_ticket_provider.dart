import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/tombola/repositories/type_ticket_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class TypeTicketsListNotifier extends ListNotifier<TypeTicket> {
  final TypeTicketRepository _typeTicketsRepository = TypeTicketRepository();
  late final String raffleId;
  TypeTicketsListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _typeTicketsRepository.setToken(token);
  }

  void setId(String id) {
    raffleId = id;
  }

  Future<AsyncValue<List<TypeTicket>>> loadTypeTicketList(
      String raffleId) async {
    return await loadList(
        () async => _typeTicketsRepository.getTypeTicketsList(raffleId));
  }

  Future<bool> addTypeTicket(TypeTicket typeTicket) async {
    return add(_typeTicketsRepository.createTypeTicket, typeTicket);
  }

  Future<bool> deleteTypeTicket(TypeTicket typeTicket) async {
    return delete(
      _typeTicketsRepository.deleteTypeTicket,
      (typeTickets, t) =>
          typeTickets..removeWhere((e) => e.nbTicket == t.nbTicket),
      "TODO",
      typeTicket,
    );
  }

  Future<bool> updateTypeTicket(TypeTicket typeTicket) async {
    return update(
        _typeTicketsRepository.updateTypeTicket,
        (typeTickets, t) => typeTickets
          ..[typeTickets.indexWhere((e) => e.nbTicket == t.nbTicket)] = t,
        typeTicket);
  }
}

final typeTicketsListProvider = StateNotifierProvider<TypeTicketsListNotifier,
    AsyncValue<List<TypeTicket>>>((ref) {
  final token = ref.watch(tokenProvider);
  return TypeTicketsListNotifier(token: token);
});

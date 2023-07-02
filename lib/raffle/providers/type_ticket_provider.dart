import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/raffle/class/raffle.dart';
import 'package:myecl/raffle/class/type_ticket_simple.dart';
import 'package:myecl/raffle/providers/raffle_id_provider.dart';
import 'package:myecl/raffle/repositories/raffle_detail_repository.dart';
import 'package:myecl/raffle/repositories/type_ticket_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class TypeTicketSimplesListNotifier extends ListNotifier<TypeTicketSimple> {
  final TypeTicketSimpleRepository _typeTicketsRepository =
      TypeTicketSimpleRepository();
  final RaffleDetailRepository _raffleDetailRepository =
      RaffleDetailRepository();
  late String raffleId;
  TypeTicketSimplesListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _typeTicketsRepository.setToken(token);
    _raffleDetailRepository.setToken(token);
  }

  void setRaffleId(String id) {
    raffleId = id;
  }

  Future<AsyncValue<List<TypeTicketSimple>>> loadTypeTicketSimpleList() async {
    return await loadList(() async =>
        _raffleDetailRepository.getTypeTicketSimpleListFromRaffle(raffleId));
  }

  Future<bool> addTypeTicketSimple(TypeTicketSimple typeTicket) async {
    return add(_typeTicketsRepository.createTypeTicketSimple, typeTicket);
  }

  Future<bool> deleteTypeTicketSimple(TypeTicketSimple typeTicket) async {
    return delete(
      _typeTicketsRepository.deleteTypeTicketSimple,
      (typeTickets, t) => typeTickets..removeWhere((e) => e.id == t.id),
      typeTicket.id,
      typeTicket,
    );
  }

  Future<bool> updateTypeTicketSimple(TypeTicketSimple typeTicket) async {
    return update(
        _typeTicketsRepository.updateTypeTicketSimple,
        (typeTickets, t) =>
            typeTickets..[typeTickets.indexWhere((e) => e.id == t.id)] = t,
        typeTicket);
  }
}

final typeTicketsListProvider = StateNotifierProvider<
    TypeTicketSimplesListNotifier, AsyncValue<List<TypeTicketSimple>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = TypeTicketSimplesListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final raffleId = ref.watch(raffleIdProvider);
    if (raffleId != Raffle.empty().id) {
      notifier.setRaffleId(raffleId);
      notifier.loadTypeTicketSimpleList();
    }
  });
  return notifier;
});

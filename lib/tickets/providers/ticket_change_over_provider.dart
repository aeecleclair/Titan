import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/ticket_change_over_invitation.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tools/exception.dart';

class TicketChangeOverNotifier extends StateNotifier<AsyncValue<void>> {
  final TicketsRepository _ticketsRepository;

  TicketChangeOverNotifier({required TicketsRepository ticketsRepository})
    : _ticketsRepository = ticketsRepository,
      super(const AsyncValue.data(null));

  Future<bool> requestChangeOver(String ticketId, String email) async {
    state = const AsyncValue.loading();
    try {
      await _ticketsRepository.requestTicketChangeOver(
        TicketChangeOverInvitation(ticketId: ticketId, email: email),
      );
      state = const AsyncValue.data(null);
      return true;
    } on AppException catch (e, stackTrace) {
      state = AsyncValue.error(e.message, stackTrace);
      return false;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e.toString(), stackTrace);
      return false;
    }
  }
}

final ticketChangeOverProvider =
    StateNotifierProvider<TicketChangeOverNotifier, AsyncValue<void>>((ref) {
      final ticketsRepository = ref.watch(ticketsRepositoryProvider);
      return TicketChangeOverNotifier(ticketsRepository: ticketsRepository);
    });

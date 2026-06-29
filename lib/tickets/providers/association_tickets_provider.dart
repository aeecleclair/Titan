import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';

final associationTicketEventListProvider =
    FutureProvider.family<List<TicketEvent>, String>((
      ref,
      associationId,
    ) async {
      final repository = ref.watch(ticketsRepositoryProvider);
      return await repository.getTicketEventListByAssociationId(associationId);
    });

class SelectedAssociationTicketEventListNotifier
    extends StateNotifier<AsyncValue<List<TicketEvent>>> {
  final TicketsRepository _repository;
  String? _currentAssociationId;

  SelectedAssociationTicketEventListNotifier(this._repository)
    : super(const AsyncValue.data([]));

  Future<void> loadTicketEvents(String? associationId) async {
    _currentAssociationId = associationId;
    if (associationId == null) {
      state = const AsyncValue.data([]);
      return;
    }
    state = const AsyncValue.loading();
    try {
      final events = await _repository.getTicketEventListByAssociationId(
        associationId,
      );
      state = AsyncValue.data(events);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    if (_currentAssociationId != null) {
      await loadTicketEvents(_currentAssociationId);
    }
  }
}

final selectedAssociationTicketEventListProvider =
    StateNotifierProvider.family<
      SelectedAssociationTicketEventListNotifier,
      AsyncValue<List<TicketEvent>>,
      String?
    >((ref, associationId) {
      final repository = ref.watch(ticketsRepositoryProvider);
      final notifier = SelectedAssociationTicketEventListNotifier(repository);
      notifier.loadTicketEvents(associationId);
      return notifier;
    });

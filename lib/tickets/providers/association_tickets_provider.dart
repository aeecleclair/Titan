import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/ticket_event_repository.dart';

// Provider family existant
final associationTicketEventListProvider =
    FutureProvider.family<List<TicketEvent>, String>((
      ref,
      associationId,
    ) async {
      final repository = ref.watch(ticketEventRepositoryProvider);
      return await repository.getTicketEventListByAssociationId(associationId);
    });

// NOUVEAU : Notifier pour gérer l'état des ticket events avec rafraîchissement
class SelectedAssociationTicketEventListNotifier
    extends StateNotifier<AsyncValue<List<TicketEvent>>> {
  final TicketEventRepository _repository;
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

// NOUVEAU : Provider qui prend une association nullable avec StateNotifier
final selectedAssociationTicketEventListProvider = StateNotifierProvider
    .family<SelectedAssociationTicketEventListNotifier,
        AsyncValue<List<TicketEvent>>, String?>((ref, associationId) {
      final repository = ref.watch(ticketEventRepositoryProvider);
      final notifier = SelectedAssociationTicketEventListNotifier(repository);
      // Charger les données initiales
      notifier.loadTicketEvents(associationId);
      return notifier;
    });

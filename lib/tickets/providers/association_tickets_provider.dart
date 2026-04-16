// Dans association_ticket_event_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

// NOUVEAU : Provider qui prend une association nullable
final selectedAssociationTicketEventListProvider =
    FutureProvider.family<List<TicketEvent>, String?>((
      ref,
      associationId,
    ) async {
      if (associationId == null) return [];
      final repository = ref.watch(ticketEventRepositoryProvider);
      return await repository.getTicketEventListByAssociationId(associationId);
    });

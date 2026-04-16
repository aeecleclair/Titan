import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/class/category.dart';
import 'package:titan/tickets/class/session.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';

class ShotgunEditNotifier extends StateNotifier<AsyncValue<void>> {
  final TicketsRepository repository;

  ShotgunEditNotifier({required this.repository})
    : super(const AsyncValue.data(null));

  Future<bool> editTicketEvent(TicketEvent ticketEvent) async {
    state = const AsyncValue.loading();
    try {
      final result = await repository.editTicketEvent(ticketEvent);
      state = const AsyncValue.data(null);
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> updateSession(String eventId, Session session) async {
    try {
      return await repository.updateSession(eventId, session);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> updateCategory(String eventId, Category category) async {
    try {
      return await repository.updateCategory(eventId, category);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> updateQuestion(
    String eventId,
    String questionId,
    String questionText,
  ) async {
    try {
      return await repository.updateQuestion(eventId, questionId, questionText);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final ticketEventEditProvider =
    StateNotifierProvider<ShotgunEditNotifier, AsyncValue<void>>((ref) {
      final token = ref.watch(tokenProvider);
      final repository = TicketsRepository()..setToken(token);
      return ShotgunEditNotifier(repository: repository);
    });

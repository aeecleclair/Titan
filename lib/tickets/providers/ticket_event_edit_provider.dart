import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/answer_type.dart';
import 'package:titan/tickets/class/category.dart';
import 'package:titan/tickets/class/question.dart';
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

  Future<Session?> addSession(String eventId, Session session) async {
    try {
      return await repository.addSession(eventId, session);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
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

  Future<bool> updateSessionDisabled(
    String eventId,
    String sessionId,
    bool disabled,
  ) async {
    try {
      return await repository.updateSessionDisabled(
        eventId,
        sessionId,
        disabled,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deleteSession(String eventId, String sessionId) async {
    try {
      return await repository.deleteSession(eventId, sessionId);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<Category?> addCategory(String eventId, Category category) async {
    try {
      return await repository.addCategory(eventId, category);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
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

  Future<bool> updateCategoryDisabled(
    String eventId,
    String categoryId,
    bool disabled,
  ) async {
    try {
      return await repository.updateCategoryDisabled(
        eventId,
        categoryId,
        disabled,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deleteCategory(String eventId, String categoryId) async {
    try {
      return await repository.deleteCategory(eventId, categoryId);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<Question?> createQuestion(
    String eventId, {
    required String questionText,
    required AnswerType answerType,
    required bool required,
    int? price,
  }) async {
    try {
      return await repository.createQuestion(
        eventId,
        questionText: questionText,
        answerType: answerType,
        required: required,
        price: price,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> updateQuestion(
    String eventId,
    String questionId, {
    required String questionText,
    required AnswerType answerType,
    required bool required,
    int? price,
    bool? disabled,
  }) async {
    try {
      return await repository.updateQuestion(
        eventId,
        questionId,
        questionText: questionText,
        answerType: answerType,
        required: required,
        price: price,
        disabled: disabled,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> updateQuestionDisabled(
    String eventId,
    String questionId,
    bool disabled,
  ) async {
    try {
      return await repository.updateQuestionDisabled(
        eventId,
        questionId,
        disabled,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deleteQuestion(String eventId, String questionId) async {
    try {
      return await repository.deleteQuestion(eventId, questionId);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final ticketEventEditProvider =
    StateNotifierProvider<ShotgunEditNotifier, AsyncValue<void>>((ref) {
      final repository = ref.watch(ticketsRepositoryProvider);
      return ShotgunEditNotifier(repository: repository);
    });

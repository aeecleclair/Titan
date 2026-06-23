import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/answer_type.dart';
import 'package:titan/tickets/class/category.dart';
import 'package:titan/tickets/class/question.dart';
import 'package:titan/tickets/class/session.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tools/providers/action_notifier.dart';

class TicketEventEditNotifier extends ActionNotifier {
  final TicketsRepository repository;

  TicketEventEditNotifier({required this.repository});

  Future<bool> editTicketEvent(TicketEvent ticketEvent) =>
      runBool(() => repository.editTicketEvent(ticketEvent), showLoading: true);

  Future<Session?> addSession(String eventId, Session session) =>
      run(() => repository.addSession(eventId, session));

  Future<bool> updateSession(String eventId, Session session) =>
      runBool(() => repository.updateSession(eventId, session));

  Future<bool> updateSessionDisabled(
    String eventId,
    String sessionId,
    bool disabled,
  ) => runBool(
    () => repository.updateSessionDisabled(eventId, sessionId, disabled),
  );

  Future<bool> deleteSession(String eventId, String sessionId) =>
      runBool(() => repository.deleteSession(eventId, sessionId));

  Future<Category?> addCategory(String eventId, Category category) =>
      run(() => repository.addCategory(eventId, category));

  Future<bool> updateCategory(String eventId, Category category) =>
      runBool(() => repository.updateCategory(eventId, category));

  Future<bool> updateCategoryDisabled(
    String eventId,
    String categoryId,
    bool disabled,
  ) => runBool(
    () => repository.updateCategoryDisabled(eventId, categoryId, disabled),
  );

  Future<bool> deleteCategory(String eventId, String categoryId) =>
      runBool(() => repository.deleteCategory(eventId, categoryId));

  Future<Question?> createQuestion(
    String eventId, {
    required String questionText,
    required AnswerType answerType,
    required bool required,
    int? price,
  }) => run(
    () => repository.createQuestion(
      eventId,
      questionText: questionText,
      answerType: answerType,
      required: required,
      price: price,
    ),
  );

  Future<bool> updateQuestion(
    String eventId,
    String questionId, {
    required String questionText,
    required AnswerType answerType,
    required bool required,
    int? price,
    bool? disabled,
  }) => runBool(
    () => repository.updateQuestion(
      eventId,
      questionId,
      questionText: questionText,
      answerType: answerType,
      required: required,
      price: price,
      disabled: disabled,
    ),
  );

  Future<bool> updateQuestionDisabled(
    String eventId,
    String questionId,
    bool disabled,
  ) => runBool(
    () => repository.updateQuestionDisabled(eventId, questionId, disabled),
  );

  Future<bool> deleteQuestion(String eventId, String questionId) =>
      runBool(() => repository.deleteQuestion(eventId, questionId));

  Future<bool> deleteTicketEvent(String id) =>
      runBool(() => repository.deleteTicketEvent(id), showLoading: true);
}

final ticketEventEditProvider =
    StateNotifierProvider<TicketEventEditNotifier, AsyncValue<void>>((ref) {
      final repository = ref.watch(ticketsRepositoryProvider);
      return TicketEventEditNotifier(repository: repository);
    });

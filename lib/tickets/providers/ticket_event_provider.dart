import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tickets/adapters/category.dart';
import 'package:titan/tickets/adapters/question.dart';
import 'package:titan/tickets/adapters/session.dart';
import 'package:titan/tickets/adapters/ticket_event.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

/// The event an admin is currently looking at, plus every edit that can be made
/// to it.
///
/// Sessions, categories and questions live inside [EventAdmin], so their
/// endpoints all go through [update]: the request is sent, and on success the
/// state becomes the locally recomputed event. That avoids a refetch, which
/// would discard the unsaved form input the edit page is holding.
class TicketEventNotifier extends SingleNotifierAPI<EventAdmin> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<EventAdmin> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<EventAdmin>> loadTicketEvent(String eventId) async {
    return await load(
      () => repository.ticketsAdminEventsEventIdGet(eventId: eventId),
    );
  }

  void setTicketEvent(EventAdmin ticketEvent) {
    state = AsyncValue.data(ticketEvent);
  }

  Future<bool> editTicketEvent(EventAdmin ticketEvent) async {
    return await update(
      () => repository.ticketsAdminEventsEventIdPatch(
        eventId: ticketEvent.id,
        body: ticketEvent.toEventUpdate(),
      ),
      ticketEvent,
    );
  }

  Future<bool> deleteEvent(String eventId) async {
    return await delete(
      () => repository.ticketsAdminEventsEventIdDelete(eventId: eventId),
    );
  }

  // --- Sessions ---

  /// Returns the created session, or null when the backend refused it.
  ///
  /// The id only exists once the response comes back, so the merged event is
  /// applied after [update] rather than being handed to it up front.
  Future<SessionAdmin?> createSession(
    EventAdmin event,
    SessionCreate session,
  ) async {
    SessionComplete? created;
    await update(() async {
      final response = await repository.ticketsAdminEventsEventIdSessionsPost(
        eventId: event.id,
        body: session,
      );
      if (response.isSuccessful) created = response.body;
      return response;
    }, event);

    final body = created;
    if (body == null) return null;
    final admin = body.toSessionAdmin();
    setTicketEvent(event.copyWith(sessions: [...event.sessions, admin]));
    return admin;
  }

  Future<bool> updateSession(EventAdmin event, SessionAdmin session) async {
    return await update(
      () => repository.ticketsAdminEventsEventIdSessionsSessionIdPatch(
        eventId: event.id,
        sessionId: session.id,
        body: session.toSessionUpdate(),
      ),
      event.copyWith(
        sessions: [
          for (final s in event.sessions) s.id == session.id ? session : s,
        ],
      ),
    );
  }

  Future<bool> deleteSession(EventAdmin event, String sessionId) async {
    return await update(
      () => repository.ticketsAdminEventsEventIdSessionsSessionIdDelete(
        eventId: event.id,
        sessionId: sessionId,
      ),
      event.copyWith(
        sessions: event.sessions.where((s) => s.id != sessionId).toList(),
      ),
    );
  }

  // --- Categories ---

  /// Returns the created category, or null when the backend refused it.
  ///
  /// The id only exists once the response comes back, so the merged event is
  /// applied after [update] rather than being handed to it up front.
  Future<CategoryAdmin?> createCategory(
    EventAdmin event,
    CategoryCreate category,
  ) async {
    CategoryComplete? created;
    await update(() async {
      final response = await repository.ticketsAdminEventsEventIdCategoriesPost(
        eventId: event.id,
        body: category,
      );
      if (response.isSuccessful) created = response.body;
      return response;
    }, event);

    final body = created;
    if (body == null) return null;
    final admin = body.toCategoryAdmin();
    setTicketEvent(event.copyWith(categories: [...event.categories, admin]));
    return admin;
  }

  Future<bool> updateCategory(EventAdmin event, CategoryAdmin category) async {
    return await update(
      () => repository.ticketsAdminEventsEventIdCategoriesCategoryIdPatch(
        eventId: event.id,
        categoryId: category.id,
        body: category.toCategoryUpdate(),
      ),
      event.copyWith(
        categories: [
          for (final c in event.categories) c.id == category.id ? category : c,
        ],
      ),
    );
  }

  Future<bool> deleteCategory(EventAdmin event, String categoryId) async {
    return await update(
      () => repository.ticketsAdminEventsEventIdCategoriesCategoryIdDelete(
        eventId: event.id,
        categoryId: categoryId,
      ),
      event.copyWith(
        categories: event.categories.where((c) => c.id != categoryId).toList(),
      ),
    );
  }

  // --- Questions ---

  /// Returns the created question, or null when the backend refused it.
  Future<QuestionAdmin?> createQuestion(
    EventAdmin event,
    QuestionCreate question,
  ) async {
    Question? created;
    await update(() async {
      final response = await repository.ticketsAdminEventsEventIdQuestionsPost(
        eventId: event.id,
        body: question,
      );
      if (response.isSuccessful) created = response.body;
      return response;
    }, event);

    final body = created;
    if (body == null) return null;
    final admin = body.toQuestionAdmin();
    setTicketEvent(event.copyWith(questions: [...event.questions, admin]));
    return admin;
  }

  Future<bool> updateQuestion(EventAdmin event, QuestionAdmin question) async {
    return await update(
      () => repository.ticketsAdminEventsEventIdQuestionsQuestionIdPatch(
        eventId: event.id,
        questionId: question.id,
        body: question.toQuestionUpdate(),
      ),
      event.copyWith(
        questions: [
          for (final q in event.questions) q.id == question.id ? question : q,
        ],
      ),
    );
  }

  Future<bool> deleteQuestion(EventAdmin event, String questionId) async {
    return await update(
      () => repository.ticketsAdminEventsEventIdQuestionsQuestionIdDelete(
        eventId: event.id,
        questionId: questionId,
      ),
      event.copyWith(
        questions: event.questions.where((q) => q.id != questionId).toList(),
      ),
    );
  }
}

final ticketEventProvider =
    NotifierProvider<TicketEventNotifier, AsyncValue<EventAdmin>>(
      TicketEventNotifier.new,
    );

class PublicTicketEventByIdNotifier extends AsyncNotifier<EventPublic> {
  PublicTicketEventByIdNotifier(this._id);

  final String _id;

  Openapi get repository => ref.watch(repositoryProvider);

  @override
  Future<EventPublic> build() async {
    final response = await repository.ticketsEventsEventIdGet(eventId: _id);
    return response.body!;
  }
}

final publicTicketEventByIdProvider =
    AsyncNotifierProvider.family<
      PublicTicketEventByIdNotifier,
      EventPublic,
      String
    >(PublicTicketEventByIdNotifier.new);

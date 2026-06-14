import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/class/answer_type.dart';
import 'package:titan/tickets/class/category.dart';
import 'package:titan/tickets/class/checkout.dart';
import 'package:titan/tickets/class/question.dart';
import 'package:titan/tickets/class/session.dart';
import 'package:titan/tickets/class/ticket_change_over_invitation.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/class/ticket.dart';
import 'package:titan/tickets/class/user_ticket.dart';
import 'package:titan/tickets/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class TicketsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tickets/";

  Future<List<TicketEvent>> getAllShotgun() async {
    return (await getList(
      suffix: 'events',
    )).map((e) => TicketEvent.fromJson(e)).toList();
  }

  Future<TicketEvent> getTicketEventById(String id) async {
    return TicketEvent.fromJson(await getOne("admin/events/$id"));
  }

  Future<TicketEvent> getPublicTicketEventById(String id) async {
    return TicketEvent.fromJson(await getOne("events/$id"));
  }

  Future<List<TicketEvent>> getShotgunListByAssociationId(String id) async {
    return (await getList(
      suffix: 'admin/association/$id/events',
    )).map((e) => TicketEvent.fromJson(e)).toList();
  }

  Future<List<TicketEvent>> getShotgunListByStoreId(String id) async {
    return (await getList(
      suffix: 'admin/store/$id/events',
    )).map((e) => TicketEvent.fromJson(e)).toList();
  }

  Future<TicketEvent> createTicketEvent(TicketEvent ticketEvent) async {
    return TicketEvent.fromJson(
      await create(ticketEvent.toJson(), suffix: 'admin/events'),
    );
  }

  Future<Checkout> checkoutShotgun(TicketEvent ticketEvent) async {
    return Checkout.fromJson(
      await create(
        checkoutFromShotgun(ticketEvent).toJson(),
        suffix: 'events/${ticketEvent.id}/checkout',
      ),
    );
  }

  Future<bool> editTicketEvent(TicketEvent ticketEvent) async {
    return await update(
      ticketEvent.toUpdateJson(),
      'admin/events/${ticketEvent.id}',
    );
  }

  Future<Session> addSession(String eventId, Session session) async {
    return Session.fromJson(
      await create(
        session.toCreateJson(),
        suffix: 'admin/events/$eventId/sessions',
      ),
    );
  }

  Future<bool> updateSession(String eventId, Session session) async {
    return update(
      session.toJson(),
      'admin/events/$eventId/sessions/${session.id}',
    );
  }

  Future<bool> updateSessionDisabled(
    String eventId,
    String sessionId,
    bool disabled,
  ) async {
    return update(
      {'disabled': disabled},
      'admin/events/$eventId/sessions/$sessionId',
    );
  }

  Future<bool> deleteSession(String eventId, String sessionId) async {
    return delete('admin/events/$eventId/sessions/$sessionId');
  }

  Future<Category> addCategory(String eventId, Category category) async {
    return Category.fromJson(
      await create(
        category.toCreateJson(),
        suffix: 'admin/events/$eventId/categories',
      ),
    );
  }

  Future<bool> updateCategory(String eventId, Category category) async {
    return update(
      category.toJson(),
      'admin/events/$eventId/categories/${category.id}',
    );
  }

  Future<bool> updateCategoryDisabled(
    String eventId,
    String categoryId,
    bool disabled,
  ) async {
    return update(
      {'disabled': disabled},
      'admin/events/$eventId/categories/$categoryId',
    );
  }

  Future<bool> deleteCategory(String eventId, String categoryId) async {
    return delete('admin/events/$eventId/categories/$categoryId');
  }

  Future<bool> updateQuestionDisabled(
    String eventId,
    String questionId,
    bool disabled,
  ) async {
    return update(
      {'disabled': disabled},
      'admin/events/$eventId/questions/$questionId',
    );
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
    final body = <String, dynamic>{
      'question': questionText,
      'answer_type': answerType.value,
      'required': required,
      'price': price != null ? price * 100 : null,
    };
    if (disabled != null) {
      body['disabled'] = disabled;
    }
    return update(body, 'admin/events/$eventId/questions/$questionId');
  }

  Future<Question> createQuestion(
    String eventId, {
    required String questionText,
    required AnswerType answerType,
    required bool required,
    int? price,
  }) async {
    return Question.fromJson(
      await create({
        'question': questionText,
        'answer_type': answerType.value,
        'required': required,
        'price': price != null ? price * 100 : null,
      }, suffix: 'admin/events/$eventId/questions'),
    );
  }

  Future<bool> deleteQuestion(String eventId, String questionId) async {
    return delete('admin/events/$eventId/questions/$questionId');
  }

  Future<bool> deleteTicketEvent(String id) async {
    return await delete(id);
  }

  Future<List<UserTicket>> getUserTickets() async {
    final List<dynamic> response = await getList(suffix: 'user/me/tickets');
    return response.map((e) {
      return UserTicket.fromJson(e);
    }).toList();
  }

  Future<bool> requestTicketChangeOver(
    TicketChangeOverInvitation invitation,
  ) async {
    return await create(
      invitation.toJson(),
      suffix: 'user/me/tickets/change-over/request',
    );
  }

  Future<List<Ticket>> getTicketsByEventId(String eventId) async {
    final List<dynamic> response = await getList(
      suffix: 'admin/events/$eventId/tickets',
    );
    return response.map((e) {
      return Ticket.fromJson(e);
    }).toList();
  }

  Future<Uint8List> downloadTicketsCsv(String eventId) async {
    final response = await http.get(
      Uri.parse('${Repository.host}${ext}admin/events/$eventId/tickets/csv'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to download CSV: ${response.statusCode}');
    }
  }
}

final ticketsRepositoryProvider = Provider<TicketsRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return TicketsRepository()..setToken(token);
});

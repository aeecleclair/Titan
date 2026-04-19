import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/class/answer_type.dart';
import 'package:titan/tickets/class/category.dart';
import 'package:titan/tickets/class/checkout.dart';
import 'package:titan/tickets/class/session.dart';
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
      ticketEvent.toJson(),
      ticketEvent.id,
      suffix: 'admin/events',
    );
  }

  Future<bool> updateSession(String eventId, Session session) async {
    final response = await http.patch(
      Uri.parse(
        '${Repository.host}${ext}admin/events/$eventId/sessions/${session.id}',
      ),
      headers: headers,
      body: jsonEncode(session.toJson()),
    );
    if (response.statusCode == 204 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
        'Failed to update session: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<bool> updateCategory(String eventId, Category category) async {
    final response = await http.patch(
      Uri.parse(
        '${Repository.host}${ext}admin/events/$eventId/categories/${category.id}',
      ),
      headers: headers,
      body: jsonEncode(category.toJson()),
    );
    if (response.statusCode == 204 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
        'Failed to update category: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<bool> updateQuestion(
    String eventId,
    String questionId,
    String questionText,
    AnswerType answerType,
    bool required,
  ) async {
    final response = await http.patch(
      Uri.parse(
        '${Repository.host}${ext}admin/events/$eventId/questions/$questionId',
      ),
      headers: headers,
      body: jsonEncode({
        'question': questionText,
        'answer_type': answerType.value,
        'required': required,
      }),
    );
    if (response.statusCode == 204 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
        'Failed to update question: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<bool> createQuestion(
    String eventId,
    String questionText,
    AnswerType answerType,
    bool required,
  ) async {
    final response = await http.post(
      Uri.parse('${Repository.host}${ext}admin/events/$eventId/questions'),
      headers: headers,
      body: jsonEncode({
        'question': questionText,
        'answer_type': answerType.value,
        'required': required,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
        'Failed to create question: ${response.statusCode} ${response.body}',
      );
    }
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

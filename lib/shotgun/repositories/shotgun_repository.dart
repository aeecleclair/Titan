import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/category.dart';
import 'package:titan/shotgun/class/checkout.dart';
import 'package:titan/shotgun/class/session.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/class/ticket.dart';
import 'package:titan/shotgun/class/user_ticket.dart';
import 'package:titan/shotgun/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class ShotgunRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tickets/";

  Future<List<Shotgun>> getAllShotgun() async {
    return (await getList(
      suffix: 'events',
    )).map((e) => Shotgun.fromJson(e)).toList();
  }

  Future<Shotgun> getShotgunById(String id) async {
    return Shotgun.fromJson(await getOne("admin/events/$id"));
  }

  Future<Shotgun> getPublicShotgunById(String id) async {
    return Shotgun.fromJson(await getOne("events/$id"));
  }

  Future<List<Shotgun>> getShotgunListByAssociationId(String id) async {
    return (await getList(
      suffix: 'admin/association/$id/events',
    )).map((e) => Shotgun.fromJson(e)).toList();
  }

  Future<List<Shotgun>> getShotgunListByStoreId(String id) async {
    return (await getList(
      suffix: 'admin/store/$id/events',
    )).map((e) => Shotgun.fromJson(e)).toList();
  }

  Future<Shotgun> createShotgun(Shotgun shotgun) async {
    return Shotgun.fromJson(
      await create(shotgun.toJson(), suffix: 'admin/events'),
    );
  }

  Future<Checkout> checkoutShotgun(Shotgun shotgun) async {
    return Checkout.fromJson(
      await create(
        checkoutFromShotgun(shotgun).toJson(),
        suffix: 'events/${shotgun.id}/checkout',
      ),
    );
  }

  Future<bool> editShotgun(Shotgun shotgun) async {
    return await update(shotgun.toJson(), shotgun.id, suffix: 'admin/events');
  }

  Future<bool> updateSession(String eventId, Session session) async {
    final response = await http.patch(
      Uri.parse('${Repository.host}${ext}admin/events/$eventId/sessions/${session.id}'),
      headers: headers,
      body: jsonEncode(session.toJson()),
    );
    if (response.statusCode == 204 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update session: ${response.statusCode} ${response.body}');
    }
  }

  Future<bool> updateCategory(String eventId, Category category) async {
    final response = await http.patch(
      Uri.parse('${Repository.host}${ext}admin/events/$eventId/categories/${category.id}'),
      headers: headers,
      body: jsonEncode(category.toJson()),
    );
    if (response.statusCode == 204 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update category: ${response.statusCode} ${response.body}');
    }
  }

  Future<bool> updateQuestion(
    String eventId,
    String questionId,
    String questionText,
  ) async {
    return await update(
      {'question': questionText},
      questionId,
      suffix: 'admin/events/$eventId/questions',
    );
  }

  Future<bool> deleteShotgun(String id) async {
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

final shotgunRepositoryProvider = Provider<ShotgunRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return ShotgunRepository()..setToken(token);
});

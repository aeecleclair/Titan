import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/category.dart';
import 'package:titan/shotgun/class/checkout.dart';
import 'package:titan/shotgun/class/session.dart';
import 'package:titan/shotgun/class/shotgun.dart';
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
    return await update(
      shotgun.toJson(),
      shotgun.id,
      suffix: 'admin/events',
    );
  }

  Future<bool> updateSession(String eventId, Session session) async {
    return await update(
      session.toJson(),
      session.id,
      suffix: 'admin/events/$eventId/sessions',
    );
  }

  Future<bool> updateCategory(String eventId, Category category) async {
    return await update(
      category.toJson(),
      category.id,
      suffix: 'admin/events/$eventId/categories',
    );
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
    return (await getList(
      suffix: 'user/me/tickets',
    )).map((e) => UserTicket.fromJson(e)).toList();
  }
}

final shotgunRepositoryProvider = Provider<ShotgunRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return ShotgunRepository()..setToken(token);
});

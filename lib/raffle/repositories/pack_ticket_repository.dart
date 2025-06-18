import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/raffle/class/pack_ticket.dart';
import 'package:myecl/tools/repository/repository.dart';

class PackTicketRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/pack_tickets";

  PackTicketRepository(super.ref);

  Future<PackTicket> getPackTicket(String id) async {
    return PackTicket.fromJson(await getOne(id));
  }

  Future<PackTicket> createPackTicket(PackTicket ticket) async {
    return PackTicket.fromJson(await create(ticket.toJson()));
  }

  Future<bool> updatePackTicket(PackTicket ticket) async {
    return await update(ticket.toJson(), "/${ticket.id}");
  }

  Future<bool> deletePackTicket(String id) async {
    return await delete("/$id");
  }
}

import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/tools/repository/repository.dart';

class TypeTicketRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/type-tickets";

  Future<List<TypeTicket>> getTypeTicketsList(String raffleId) async {
    return List<TypeTicket>.from((await getList(suffix: "/$raffleId/"))
        .map((x) => TypeTicket.fromJson(x)));
  }


  Future<TypeTicket> getTypeTicket(String id) async {
    return TypeTicket.fromJson(await getOne(id));
  }

  Future<TypeTicket> createTypeTicket(TypeTicket ticket) async {
    return TypeTicket.fromJson(await create(ticket.toJson()));
  }

  Future<bool> updateTypeTicket(TypeTicket ticket) async {
    return await update(ticket.toJson(), "/${ticket.id}");
  }

  Future<bool> deleteTypeTicket(String id) async {
    return await delete("/$id");
  }
}

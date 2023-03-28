import 'package:myecl/tombola/class/type_ticket_simple.dart';
import 'package:myecl/tools/repository/repository.dart';

class TypeTicketSimpleRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/type_tickets";

  Future<TypeTicketSimple> getTypeTicketSimple(String id) async {
    return TypeTicketSimple.fromJson(await getOne(id));
  }

  Future<TypeTicketSimple> createTypeTicketSimple(TypeTicketSimple ticket) async {
    return TypeTicketSimple.fromJson(await create(ticket.toJson()));
  }

  Future<bool> updateTypeTicketSimple(TypeTicketSimple ticket) async {
    return await update(ticket.toJson(), "/${ticket.id}");
  }

  Future<bool> deleteTypeTicketSimple(String id) async {
    return await delete("/$id");
  }
}

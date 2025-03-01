import 'package:myecl/generated/openapi.models.swagger.dart';

extension UserTicketName on UserTicket {
  String getName() {
    if (nickname == null) {
      return '$nickname ($firstname $name)';
    }
    return '$firstname $name';
  }
}
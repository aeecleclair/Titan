import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/class/type_ticket.dart';

class TypeTicketNotifier extends StateNotifier<TypeTicket> {
  TypeTicketNotifier() : super(TypeTicket.empty());

  void setLot(TypeTicket type) {
    state = type;
  }
}

final typeTicketProvider =
    StateNotifierProvider<TypeTicketNotifier, TypeTicket>((ref) {
  return TypeTicketNotifier();
});

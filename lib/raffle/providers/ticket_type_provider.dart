import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/raffle/class/type_ticket_simple.dart';

class TypeTicketSimpleNotifier extends StateNotifier<TypeTicketSimple> {
  TypeTicketSimpleNotifier() : super(TypeTicketSimple.empty());

  void setPrize(TypeTicketSimple type) {
    state = type;
  }
}

final typeTicketProvider =
    StateNotifierProvider<TypeTicketSimpleNotifier, TypeTicketSimple>((ref) {
  return TypeTicketSimpleNotifier();
});

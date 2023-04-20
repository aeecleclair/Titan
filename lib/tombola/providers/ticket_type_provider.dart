import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/class/pack_ticket.dart';

class PackTicketNotifier extends StateNotifier<PackTicket> {
  PackTicketNotifier() : super(PackTicket.empty());

  void setLot(PackTicket type) {
    state = type;
  }
}

final packTicketProvider =
    StateNotifierProvider<PackTicketNotifier, PackTicket>((ref) {
  return PackTicketNotifier();
});

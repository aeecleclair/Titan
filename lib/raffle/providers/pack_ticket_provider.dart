import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/raffle/class/pack_ticket.dart';

class PackTicketNotifier extends StateNotifier<PackTicket> {
  PackTicketNotifier() : super(PackTicket.empty());

  void setPackTicket(PackTicket packTicket) {
    state = packTicket;
  }
}

final packTicketProvider =
    StateNotifierProvider<PackTicketNotifier, PackTicket>((ref) {
      return PackTicketNotifier();
    });

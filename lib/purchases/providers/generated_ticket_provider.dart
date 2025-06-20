import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/class/ticket_generator.dart';

class TicketGeneratorNotifier extends StateNotifier<TicketGenerator> {
  TicketGeneratorNotifier() : super(TicketGenerator.empty());

  void setTicketGenerator(TicketGenerator i) {
    state = i;
  }
}

final ticketGeneratorProvider =
    StateNotifierProvider<TicketGeneratorNotifier, TicketGenerator>((ref) {
      TicketGeneratorNotifier notifier = TicketGeneratorNotifier();
      return notifier;
    });

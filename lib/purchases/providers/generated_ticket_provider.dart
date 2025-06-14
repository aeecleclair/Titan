import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/purchases/class/ticket_generator.dart';

class TicketGeneratorNotifier extends StateNotifier<TicketGenerator> {
  TicketGeneratorNotifier({required String token})
    : super(TicketGenerator.empty());

  void setTicketGenerator(TicketGenerator i) {
    state = i;
  }
}

final ticketGeneratorProvider =
    StateNotifierProvider<TicketGeneratorNotifier, TicketGenerator>((ref) {
      final token = ref.watch(tokenProvider);
      TicketGeneratorNotifier notifier = TicketGeneratorNotifier(token: token);
      return notifier;
    });

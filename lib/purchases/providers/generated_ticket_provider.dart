import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/generated_ticket.dart';

class GeneratedTicketNotifier extends StateNotifier<GeneratedTicket> {
  GeneratedTicketNotifier({required String token})
      : super(GeneratedTicket.empty());

  void setGeneratedTicket(GeneratedTicket i) {
    state = i;
  }
}

final generatedTicketProvider =
    StateNotifierProvider<GeneratedTicketNotifier, GeneratedTicket>((ref) {
  final token = ref.watch(tokenProvider);
  GeneratedTicketNotifier notifier = GeneratedTicketNotifier(token: token);
  return notifier;
});

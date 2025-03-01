import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class TicketGeneratorNotifier extends StateNotifier<GenerateTicketComplete> {
  TicketGeneratorNotifier() : super(GenerateTicketComplete.fromJson({}));

  void setTicketGenerator(GenerateTicketComplete i) {
    state = i;
  }
}

final ticketGeneratorProvider =
    StateNotifierProvider<TicketGeneratorNotifier, GenerateTicketComplete>(
        (ref) {
  TicketGeneratorNotifier notifier = TicketGeneratorNotifier();
  return notifier;
});

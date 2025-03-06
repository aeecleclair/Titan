import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class TicketGeneratorNotifier extends StateNotifier<GenerateTicketComplete> {
  TicketGeneratorNotifier()
      : super(EmptyModels.empty<GenerateTicketComplete>());

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

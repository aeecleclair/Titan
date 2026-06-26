import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class TicketGeneratorNotifier extends Notifier<GenerateTicketComplete> {
  @override
  GenerateTicketComplete build() {
    return GenerateTicketComplete.empty();
  }

  void setTicketGenerator(GenerateTicketComplete i) {
    state = i;
  }
}

final ticketGeneratorProvider =
    NotifierProvider<TicketGeneratorNotifier, GenerateTicketComplete>(
      TicketGeneratorNotifier.new,
    );

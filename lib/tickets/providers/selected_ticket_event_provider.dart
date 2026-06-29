import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/ticket_event.dart';

class SelectedTicketEventNotifier extends StateNotifier<TicketEvent?> {
  SelectedTicketEventNotifier() : super(null);

  void setEvent(TicketEvent event) {
    state = event;
  }

  void clear() {
    state = null;
  }
}

final selectedTicketEventProvider =
    StateNotifierProvider<SelectedTicketEventNotifier, TicketEvent?>((ref) {
      return SelectedTicketEventNotifier();
    });

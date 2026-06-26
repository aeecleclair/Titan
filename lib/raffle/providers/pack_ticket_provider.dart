import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class PackTicketNotifier extends Notifier<PackTicketSimple> {
  @override
  PackTicketSimple build() {
    return PackTicketSimple.empty();
  }

  void setPackTicket(PackTicketSimple packTicket) {
    state = packTicket;
  }
}

final packTicketProvider =
    NotifierProvider<PackTicketNotifier, PackTicketSimple>(
      () => PackTicketNotifier(),
    );

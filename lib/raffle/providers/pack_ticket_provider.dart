import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class PackTicketNotifier extends StateNotifier<PackTicketSimple> {
  PackTicketNotifier() : super(PackTicketSimple.fromJson({}));

  void setPackTicket(PackTicketSimple packTicket) {
    state = packTicket;
  }
}

final packTicketProvider =
    StateNotifierProvider<PackTicketNotifier, PackTicketSimple>((ref) {
  return PackTicketNotifier();
});

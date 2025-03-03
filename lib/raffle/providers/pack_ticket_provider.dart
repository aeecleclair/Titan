import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class PackTicketNotifier extends StateNotifier<PackTicketSimple> {
  PackTicketNotifier() : super(EmptyModels.empty<PackTicketSimple>());

  void setPackTicket(PackTicketSimple packTicket) {
    state = packTicket;
  }
}

final packTicketProvider =
    StateNotifierProvider<PackTicketNotifier, PackTicketSimple>((ref) {
  return PackTicketNotifier();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class TicketIdNotifier extends SingleNotifier<String> {
  TicketIdNotifier({required String token}) : super(const AsyncValue.loading());

  void setTicketId(String i) {
    state = AsyncValue.data(i);
  }
}

final ticketIdProvider =
    StateNotifierProvider<TicketIdNotifier, AsyncValue<String>>((ref) {
  final token = ref.watch(tokenProvider);
  TicketIdNotifier notifier = TicketIdNotifier(token: token);
  return notifier;
});

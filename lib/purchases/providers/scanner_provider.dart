import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/ticket_information.dart';
import 'package:myecl/purchases/repositories/scanner_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class ScannerNotifier extends SingleNotifier<TicketInformation> {
  final ScannerRepository scannerRepository = ScannerRepository();
  ScannerNotifier({required String token}) : super(const AsyncValue.loading()) {
    scannerRepository.setToken(token);
  }
  Future<AsyncValue<TicketInformation>> scanTicket(
    String productId,
    String ticketSecret,
  ) async {
    return await load(
      () => scannerRepository.scanTicket(productId, ticketSecret),
    );
  }

  void setScanner(TicketInformation i) {
    state = AsyncValue.data(i);
  }

  void reset() {
    state = const AsyncValue.loading();
  }
}

final scannerProvider =
    StateNotifierProvider<ScannerNotifier, AsyncValue<TicketInformation>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  ScannerNotifier notifier = ScannerNotifier(token: token);
  return notifier;
});

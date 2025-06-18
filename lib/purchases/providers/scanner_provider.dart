import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/purchases/repositories/scanner_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class ScannerNotifier extends SingleNotifier<Ticket> {
  final ScannerRepository scannerRepository;
  ScannerNotifier(this.scannerRepository) : super(const AsyncValue.loading());
  Future<AsyncValue<Ticket>> scanTicket(
    String sellerId,
    String productId,
    String ticketSecret,
    String generatorId,
  ) async {
    return await load(
      () => scannerRepository.scanTicket(
        sellerId,
        productId,
        ticketSecret,
        generatorId,
      ),
    );
  }

  void setScanner(Ticket i) {
    state = AsyncValue.data(i);
  }

  void reset() {
    state = const AsyncValue.loading();
  }
}

final scannerProvider =
    StateNotifierProvider<ScannerNotifier, AsyncValue<Ticket>>((ref) {
      final scannerRepository = ScannerRepository(ref);
      ScannerNotifier notifier = ScannerNotifier(scannerRepository);
      return notifier;
    });

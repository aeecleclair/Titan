import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository.dart';

class ScannerNotifier extends SingleNotifier2<Ticket> {
  final Openapi scannerRepository;
  String secret = "";
  ScannerNotifier({required this.scannerRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<Ticket>> scanTicket(
    String sellerId,
    String productId,
    String generatorId,
  ) async {
    return await load(
      () => scannerRepository
          .cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretGet(
        sellerId: sellerId,
        productId: productId,
        generatorId: generatorId,
        secret: secret,
      ),
    );
  }

  void setScanner(Ticket i) {
    state = AsyncValue.data(i);
  }

  void reset() {
    state = const AsyncValue.loading();
    secret = "";
  }

  void setSecret(String secret) {
    this.secret = secret;
  }
}

final scannerProvider =
    StateNotifierProvider<ScannerNotifier, AsyncValue<Ticket>>((ref) {
  final scannerRepository = ref.watch(repositoryProvider);
  ScannerNotifier notifier =
      ScannerNotifier(scannerRepository: scannerRepository);
  return notifier;
});

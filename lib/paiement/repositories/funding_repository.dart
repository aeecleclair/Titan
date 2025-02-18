import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/funding_url.dart';
import 'package:myecl/paiement/class/transfert.dart';
import 'package:myecl/tools/repository/repository.dart';

class FundingRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/transfer/';


  Future<FundingUrl> getPaymentUrl(Transfer transfer) async {
    return await create(transfer.toJson());
  }
}

final fundingRepositoryProvider = Provider<FundingRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return FundingRepository()..setToken(token);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/paiement/class/funding_url.dart';
import 'package:titan/paiement/class/init_info.dart';
import 'package:titan/paiement/class/transfert.dart';
import 'package:titan/tools/repository/repository.dart';

class FundingRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/transfer/';

  Future getAdminPaymentUrl(Transfer transfer) async {
    return await create(transfer.toJson(), suffix: "admin");
  }

  Future<FundingUrl> getInitPaymentUrl(InitInfo info) async {
    return FundingUrl.fromJson(await create(info.toJson(), suffix: "init"));
  }
}

final fundingRepositoryProvider = Provider<FundingRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return FundingRepository()..setToken(token);
});

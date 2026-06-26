import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class FundingUrlNotifier extends SingleNotifierAPI<PaymentUrl> {
  Openapi get fundingRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<PaymentUrl> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<PaymentUrl>> getFundingUrl(TransferInfo info) async {
    return await load(
      () => fundingRepository.mypaymentTransferInitPost(body: info),
    );
  }
}

final fundingUrlProvider =
    NotifierProvider<FundingUrlNotifier, AsyncValue<PaymentUrl>>(
      FundingUrlNotifier.new,
    );

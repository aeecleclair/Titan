import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/class/funding_url.dart';
import 'package:titan/mypayment/class/init_info.dart';
import 'package:titan/mypayment/repositories/funding_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class FundingUrlNotifier extends SingleNotifier<FundingUrl> {
  final FundingRepository fundingRepository;
  FundingUrlNotifier({required this.fundingRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<FundingUrl>> getFundingUrl(InitInfo info) async {
    return await load(() => fundingRepository.getInitPaymentUrl(info));
  }
}

final fundingUrlProvider =
    StateNotifierProvider<FundingUrlNotifier, AsyncValue<FundingUrl>>((ref) {
      final fundingUrlRepository = ref.watch(fundingRepositoryProvider);
      return FundingUrlNotifier(fundingRepository: fundingUrlRepository);
    });

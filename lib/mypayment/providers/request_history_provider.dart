import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/class/payment_request.dart';
import 'package:titan/mypayment/repositories/requests_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class RequestHistoryNotifier extends ListNotifier<PaymentRequest> {
  final RequestsRepository requestsRepository;
  RequestHistoryNotifier({required this.requestsRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<PaymentRequest>>> getRequestHistory() async {
    return await loadList(() => requestsRepository.getRequests(used: true));
  }
}

final requestHistoryProvider = StateNotifierProvider<
  RequestHistoryNotifier,
  AsyncValue<List<PaymentRequest>>
>((ref) {
  final requestsRepository = ref.watch(requestsRepositoryProvider);
  return RequestHistoryNotifier(requestsRepository: requestsRepository)
    ..getRequestHistory();
});

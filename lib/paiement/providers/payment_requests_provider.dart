import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/class/payment_request.dart';
import 'package:titan/paiement/class/request_validation.dart';
import 'package:titan/paiement/repositories/requests_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class PaymentRequestsNotifier extends ListNotifier<PaymentRequest> {
  final RequestsRepository requestsRepository;
  PaymentRequestsNotifier({required this.requestsRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<PaymentRequest>>> getRequests() async {
    return await loadList(requestsRepository.getRequests);
  }

  Future<bool> acceptRequest(
    PaymentRequest request,
    RequestValidation validation,
  ) async {
    return await update(
      (_) => requestsRepository.acceptRequest(request.id, validation),
      (requests, request) =>
          requests
            ..[requests.indexWhere((r) => r.id == request.id)] = request,
      request.copyWith(status: RequestStatus.accepted),
    );
  }

  Future<bool> refuseRequest(PaymentRequest request) async {
    return await update(
      (_) => requestsRepository.refuseRequest(request.id),
      (requests, request) =>
          requests
            ..[requests.indexWhere((r) => r.id == request.id)] = request,
      request.copyWith(status: RequestStatus.refused),
    );
  }
}

final paymentRequestsProvider = StateNotifierProvider<
  PaymentRequestsNotifier,
  AsyncValue<List<PaymentRequest>>
>((ref) {
  final requestsRepository = ref.watch(requestsRepositoryProvider);
  return PaymentRequestsNotifier(requestsRepository: requestsRepository)
    ..getRequests();
});

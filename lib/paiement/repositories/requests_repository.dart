import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/paiement/class/payment_request.dart';
import 'package:titan/paiement/class/request_validation.dart';
import 'package:titan/tools/repository/repository.dart';

class RequestsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'mypayment/';

  Future<List<PaymentRequest>> getRequests() async {
    return List<PaymentRequest>.from(
      (await getList(suffix: 'requests')).map(
        (e) => PaymentRequest.fromJson(e),
      ),
    );
  }

  Future<bool> acceptRequest(
    String requestId,
    RequestValidation validation,
  ) async {
    await create(validation.toJson(), suffix: 'requests/$requestId/accept');
    return true;
  }

  Future<bool> refuseRequest(String requestId) async {
    await create({}, suffix: 'requests/$requestId/refuse');
    return true;
  }
}

final requestsRepositoryProvider = Provider<RequestsRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return RequestsRepository()..setToken(token);
});

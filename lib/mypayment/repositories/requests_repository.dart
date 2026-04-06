import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/mypayment/class/payment_request.dart';
import 'package:titan/mypayment/class/signed_content.dart';
import 'package:titan/tools/repository/repository.dart';

class RequestsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'mypayment/';

  Future<List<PaymentRequest>> getRequests({bool? used}) async {
    final query = used != null ? '?used=$used' : '';
    return List<PaymentRequest>.from(
      (await getList(
        suffix: 'requests$query',
      )).map((e) => PaymentRequest.fromJson(e)),
    );
  }

  Future<bool> acceptRequest(
    String requestId,
    SignedContent validation,
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

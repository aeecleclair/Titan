import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class TOSNotifier extends SingleNotifierAPI<TOSSignatureResponse> {
  Openapi get tosRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<TOSSignatureResponse> build() {
    getTOS();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<TOSSignatureResponse>> getTOS() async {
    return await load(tosRepository.mypaymentUsersMeTosGet);
  }

  Future<bool> signTOS(TOSSignatureResponse tos) async {
    return await update(
      () => tosRepository.mypaymentUsersMeTosPost(
        body: TOSSignature(acceptedTosVersion: tos.acceptedTosVersion),
      ),
      tos,
    );
  }
}

final tosProvider =
    NotifierProvider<TOSNotifier, AsyncValue<TOSSignatureResponse>>(
      TOSNotifier.new,
    );

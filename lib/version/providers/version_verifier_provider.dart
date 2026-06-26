import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class VersionVerifierNotifier extends SingleNotifierAPI<CoreInformation> {
  Openapi get versionRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<CoreInformation> build() {
    loadVersion();
    return const AsyncLoading();
  }

  Future<AsyncValue<CoreInformation>> loadVersion() async {
    return await load(versionRepository.informationGet);
  }
}

final versionVerifierProvider =
    NotifierProvider<VersionVerifierNotifier, AsyncValue<CoreInformation>>(
      VersionVerifierNotifier.new,
    );

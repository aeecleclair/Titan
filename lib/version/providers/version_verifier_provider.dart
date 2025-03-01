import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository.dart';

class VersionVerifierNotifier extends SingleNotifier2<CoreInformation> {
  final Openapi versionRepository;
  VersionVerifierNotifier({required this.versionRepository})
      : super(const AsyncLoading());

  Future<AsyncValue<CoreInformation>> loadVersion() async {
    return await load(versionRepository.informationGet);
  }
}

final versionVerifierProvider =
    StateNotifierProvider<VersionVerifierNotifier, AsyncValue<CoreInformation>>(
        (ref) {
  final versionRepository = ref.watch(repositoryProvider);
  final notifier =
      VersionVerifierNotifier(versionRepository: versionRepository);
  notifier.loadVersion();
  return notifier;
});

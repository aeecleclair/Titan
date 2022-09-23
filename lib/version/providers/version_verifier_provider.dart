import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/version/class/version.dart';
import 'package:myecl/version/repositories/version_repository.dart';

class VersionVerifierNotifier extends SingleNotifier<Version> {
  final VersionRepository _versionRepository = VersionRepository();
  VersionVerifierNotifier() : super(const AsyncLoading());

  Future<AsyncValue<Version>> loadVersion() async {
    // return await load(_versionRepository.getVersion);
    state = AsyncData(
        Version(version: '1.0.0', minimalTitanVersion: '1.0.0', ready: true));
    return state;
  }
}

final versionVerifierProvider =
    StateNotifierProvider<VersionVerifierNotifier, AsyncValue<Version>>((ref) {
  final notifier = VersionVerifierNotifier();
  notifier.loadVersion();
  return notifier;
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/version/class/version.dart';
import 'package:titan/version/repositories/version_repository.dart';

class VersionVerifierNotifier extends SingleNotifier<Version> {
  final VersionRepository versionRepository;
  VersionVerifierNotifier({required this.versionRepository})
    : super(const AsyncLoading());

  Future<AsyncValue<Version>> loadVersion() async {
    return await load(versionRepository.getVersion);
  }
}

final versionVerifierProvider =
    StateNotifierProvider<VersionVerifierNotifier, AsyncValue<Version>>((ref) {
      final versionRepository = ref.watch(versionRepositoryProvider);
      final notifier = VersionVerifierNotifier(
        versionRepository: versionRepository,
      );
      notifier.loadVersion();
      return notifier;
    });

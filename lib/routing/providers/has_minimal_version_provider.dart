import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';

final hasMinimalVersionProvider = Provider<bool>((ref) {
  final versionVerifier = ref.watch(versionVerifierProvider);
  final titanVersion = ref.watch(titanVersionProvider);
  return versionVerifier.maybeWhen(
    data: (verifier) {
      return titanVersion >= verifier.minimalTitanVersion;
    },
    // If the version verifier is still loading, we assume the app has the minimal version
    // the idea is that we don't want to have false negatives and block the user
    orElse: () {
      return true;
    },
  );
});

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';

final isAppLoadingProvider = StateProvider<bool>((ref) {
  final versionVerifier = ref.watch(versionVerifierProvider);
  final isAuthLoading = ref.watch(isAuthLoadingProvider);
  return versionVerifier.isLoading || isAuthLoading;
});

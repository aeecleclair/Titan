import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/module_root_list_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';

final isAppLoadingProvider = StateProvider<bool>((ref) {
  final versionVerifierLoading = ref.watch(
    versionVerifierProvider.select((value) => value.isLoading),
  );
  final isAuthLoading = ref.watch(isAuthLoadingProvider);
  final isLoggedIn = ref.watch(isLoggedInProvider);
  final asyncUserLoading = ref.watch(
    asyncUserProvider.select((value) => value.isLoading),
  );
  final moduleRootListLoading = ref.watch(
    moduleRootListProvider.select((value) => value.isLoading),
  );
  return versionVerifierLoading ||
      isAuthLoading ||
      (isLoggedIn && (asyncUserLoading || moduleRootListLoading));
});

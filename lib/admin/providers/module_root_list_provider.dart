import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/module_visibilities_list_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

final moduleRootListProvider =
    StateNotifierProvider<ModuleListNotifier, AsyncValue<List<String>>>((ref) {
  final token = ref.watch(tokenProvider);
  ModuleListNotifier notifier = ModuleListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadMyModuleRoots();
  });
  return notifier;
});

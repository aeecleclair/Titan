import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class RolesTagsNotifier extends SingleNotifierAPI<RoleTagsReturn> {
  Openapi get rolesTagsRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<RoleTagsReturn> build() {
    loadRolesTags();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<RoleTagsReturn>> loadRolesTags() async {
    return load(rolesTagsRepository.phonebookRoletagsGet);
  }
}

final rolesTagsProvider =
    NotifierProvider<RolesTagsNotifier, AsyncValue<RoleTagsReturn>>(
      RolesTagsNotifier.new,
    );

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class UserInvitationNotifier extends SingleNotifierAPI<BatchResult> {
  Openapi get userInvitationRepository => ref.watch(repositoryProvider);
  @override
  AsyncValue<BatchResult> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<BatchResult>> createUsers(
    List<CoreBatchUserCreateRequest> mailList,
  ) async {
    return await load(
      () => userInvitationRepository.usersBatchCreationPost(body: mailList),
    );
  }
}

final userInvitationProvider = NotifierProvider<UserInvitationNotifier, void>(
  () => UserInvitationNotifier(),
);

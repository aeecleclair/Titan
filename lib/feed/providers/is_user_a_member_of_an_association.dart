import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/repositories/user_repository.dart';

class IsUserAMemberOfAnAssociationNotifier extends SingleNotifier<bool> {
  final IsUserAMemberOfAnAssociationRepository
  isUserAMemberOfAnAssociationRepository;
  IsUserAMemberOfAnAssociationNotifier({
    required this.isUserAMemberOfAnAssociationRepository,
  }) : super(const AsyncValue.loading());
  Future<AsyncValue<bool>> loadIsUserAMemberOfAnAssociation() async {
    List<Association> associationList =
        await isUserAMemberOfAnAssociationRepository.getAssociations();
    await load(
      isUserAMemberOfAnAssociationRepository.isUserAMemberOfAnAssociation,
    );
  }
}

final asyncIsUserAMemberOfAnAssociationProvider =
    StateNotifierProvider<
      IsUserAMemberOfAnAssociationNotifier,
      AsyncValue<bool>
    >((ref) {
      final UserRepository isUserAMemberOfAnAssociationRepository = ref.watch(
        isUserAMemberOfAnAssociationRepository,
      );
      IsUserAMemberOfAnAssociationNotifier
      asyncIsUserAMemberOfAnAssociationNotifier =
          IsUserAMemberOfAnAssociationNotifier(
            isUserAMemberOfAnAssociationRepository:
                isUserAMemberOfAnAssociationRepository,
          );
      final token = ref.watch(tokenProvider);
      tokenExpireWrapperAuth(ref, () async {
        final isLoggedIn = ref.watch(isLoggedInProvider);
        final id = ref
            .watch(idProvider)
            .maybeWhen(data: (value) => value, orElse: () => "");
        if (isLoggedIn && id != "" && token != "") {
          return asyncIsUserAMemberOfAnAssociationNotifier
              .loadIsUserAMemberOfAnAssociation();
        }
      });
      return asyncIsUserAMemberOfAnAssociationNotifier;
    });

final isUserAMemberOfAnAssociationProvider = Provider((ref) {
  return ref
      .watch(asyncIsUserAMemberOfAnAssociationProvider)
      .maybeWhen(
        data: (b) => b,
        orElse: () {
          return false;
        },
      );
});

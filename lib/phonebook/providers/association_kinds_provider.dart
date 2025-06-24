import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/phonebook/class/association_kinds.dart';
import 'package:titan/phonebook/repositories/association_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class AssociationKindsNotifier extends SingleNotifier<AssociationKinds> {
  final AssociationRepository associationRepository = AssociationRepository();
  AssociationKindsNotifier({required String token})
    : super(const AsyncValue.loading()) {
    associationRepository.setToken(token);
  }

  void setKind(AssociationKinds i) {
    state = AsyncValue.data(i);
  }

  Future<AsyncValue<AssociationKinds>> loadAssociationKinds() async {
    return await load(associationRepository.getAssociationKinds);
  }
}

final associationKindsProvider =
    StateNotifierProvider<
      AssociationKindsNotifier,
      AsyncValue<AssociationKinds>
    >((ref) {
      final token = ref.watch(tokenProvider);
      AssociationKindsNotifier notifier = AssociationKindsNotifier(
        token: token,
      );
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadAssociationKinds();
      });
      return notifier;
    });

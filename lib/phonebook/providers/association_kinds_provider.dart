import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/class/association_kinds.dart';
import 'package:myecl/phonebook/repositories/association_kind_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';


class AssociationKindsNotifier extends SingleNotifier<AssociationKinds> {
  final AssociationKindsRepository associationKindsRepository = AssociationKindsRepository();
    AssociationKindsNotifier({required String token})
        : super(const AsyncValue.loading()) {
      associationKindsRepository.setToken(token);
    }

  void setKind(AssociationKinds i) {
    state = AsyncValue.data(i);
  }

  Future<AsyncValue<AssociationKinds>> loadAssociationKinds() async {
    return await load(() async => associationKindsRepository.getAssociationKinds());
  }
}

final associationKindsProvider = StateNotifierProvider<AssociationKindsNotifier, AsyncValue<AssociationKinds>>((ref) {
  final token = ref.watch(tokenProvider);
  AssociationKindsNotifier notifier  = AssociationKindsNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadAssociationKinds();
  });
  return notifier;
});
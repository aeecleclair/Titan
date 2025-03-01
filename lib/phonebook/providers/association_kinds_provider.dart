import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AssociationKindsNotifier extends SingleNotifier2<KindsReturn> {
  final Openapi associationRepository;
  AssociationKindsNotifier({required this.associationRepository})
      : super(const AsyncValue.loading());

  void setKind(KindsReturn i) {
    state = AsyncValue.data(i);
  }

  Future<AsyncValue<KindsReturn>> loadAssociationKinds() async {
    return await load(associationRepository.phonebookAssociationsKindsGet);
  }
}

final associationKindsProvider =
    StateNotifierProvider<AssociationKindsNotifier, AsyncValue<KindsReturn>>(
        (ref) {
  final associationRepository = ref.watch(repositoryProvider);
  AssociationKindsNotifier notifier =
      AssociationKindsNotifier(associationRepository: associationRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadAssociationKinds();
  });
  return notifier;
});

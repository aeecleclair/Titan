import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class AssociationKindsNotifier extends SingleNotifierAPI<KindsReturn> {
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
  return AssociationKindsNotifier(associationRepository: associationRepository)
    ..loadAssociationKinds();
});

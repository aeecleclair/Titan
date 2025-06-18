import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/association_kinds.dart';
import 'package:myecl/phonebook/repositories/association_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class AssociationKindsNotifier extends SingleNotifier<AssociationKinds> {
  final AssociationRepository associationRepository;
  AssociationKindsNotifier(this.associationRepository)
    : super(const AsyncValue.loading());

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
      final associationRepository = AssociationRepository(ref);
      AssociationKindsNotifier notifier = AssociationKindsNotifier(
        associationRepository,
      );
      notifier.loadAssociationKinds();
      return notifier;
    });

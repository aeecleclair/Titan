import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/repositories/association_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class AssociationNotifier extends SingleNotifier<Association> {
  final AssociationRepository associationRepository = AssociationRepository();
  AssociationNotifier({required String token})
      : super(const AsyncValue.loading()) {
    associationRepository.setToken(token);
  }

  Future<AsyncValue<Association>> loadAssociation(String associationId) async {
    return await load(
      () async => associationRepository.getAssociation(associationId),
    );
  }

  void setAssociation(Association association) {
    state = AsyncValue.data(association);
  }
}

final asyncAssociationProvider =
    StateNotifierProvider<AssociationNotifier, AsyncValue<Association>>((ref) {
  final token = ref.watch(tokenProvider);
  return AssociationNotifier(token: token);
});

final associationProvider = Provider<Association>((ref) {
  final association = ref.watch(asyncAssociationProvider);
  return association.maybeWhen(
    data: (association) => association,
    orElse: () => Association.empty(),
  );
});

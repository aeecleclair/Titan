import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/role.dart';
import 'package:myecl/phonebook/repositories/association_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';


class AssociationNotifier extends SingleNotifier<Association> {
  final AssociationRepository associationRepository = AssociationRepository();
  AssociationNotifier({required String token}) : super(const AsyncValue.loading()) {
    associationRepository.setToken(token);
  }

  Future<AsyncValue<Association>> loadAssociation(String associationId) async {
    return await load(() async => associationRepository.getAssociation(associationId));
  }

  Future<bool> addMember(Association association, CompleteMember user, Role role) async {
    return await update(
        (association) async => associationRepository.addMember(association, user, role), association);
  }

  Future<bool> deleteMember(Association association, CompleteMember user) async {
    return await update(
        (association) async => associationRepository.deleteMember(association, user), association);
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
      data: (association) => association, orElse: () => Association.empty());
});
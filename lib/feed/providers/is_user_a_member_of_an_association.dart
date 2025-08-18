import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/repositories/association_repository.dart';

final isUserAMemberOfAnAssociationProvider = FutureProvider<bool>((ref) async {
  final associationRepository = ref.watch(associationRepositoryProvider);
  final associations = await associationRepository.getMyAssociations();
  return associations.isNotEmpty;
});

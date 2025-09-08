import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/my_association_list_provider.dart';

final isUserAMemberOfAnAssociationProvider = Provider<bool>((ref) {
  final myAssociation = ref.watch(asyncMyAssociationListProvider);
  return myAssociation.maybeWhen(
    data: (associations) => associations.isNotEmpty,
    orElse: () => false,
  );
});

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/my_association_list_provider.dart';

final isUserAMemberOfAnAssociationProvider = FutureProvider<bool>((ref) async {
  final myAssociation = ref.watch(myAssociationListProvider);
  return myAssociation.maybeWhen(
    data: (associations) => associations.isNotEmpty,
    orElse: () => false,
  );
});

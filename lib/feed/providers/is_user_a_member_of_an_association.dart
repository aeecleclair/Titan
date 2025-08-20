import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/my_association_list_provider.dart';

final isUserAMemberOfAnAssociationProvider = StateProvider<bool>((ref) {
  final myAssociation = ref.watch(myAssociationListProvider);
  return myAssociation.isNotEmpty;
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/providers/structure_list_provider.dart';
import 'package:titan/user/providers/user_provider.dart';

final myStructuresProvider = StateProvider((ref) {
  final user = ref.watch(userProvider);
  final structures = ref.watch(structureListProvider);
  return structures.when(
    data: (structures) => structures
        .where((structure) => structure.managerUser.id == user.id)
        .toList(),
    loading: () => [],
    error: (error, stack) => [],
  );
});

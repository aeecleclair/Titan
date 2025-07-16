import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/providers/my_structures_provider.dart';

final isPaymentSuperAdminProvider = StateProvider((ref) {
  final myStructures = ref.watch(myStructuresProvider);
  return myStructures.isNotEmpty;
});

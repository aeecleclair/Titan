import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/paiement/providers/my_structures_provider.dart';

final isPaymentAdminProvider = StateProvider((ref) {
  final myStructures = ref.watch(myStructuresProvider);
  return myStructures.isNotEmpty;
});

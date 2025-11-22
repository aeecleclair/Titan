import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/tools/functions.dart';

final isRaffleAdminProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, RafflePermissionConstants.manageRaffle);
});

final isRaffleCashManagerProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, RafflePermissionConstants.manageCash);
});

final hasRaffleAdminAccessProvider = Provider<bool>((ref) {
  final isRaffleAdmin = ref.watch(isRaffleAdminProvider);
  final isRaffleCashManager = ref.watch(isRaffleCashManagerProvider);
  return isRaffleAdmin || isRaffleCashManager;
});

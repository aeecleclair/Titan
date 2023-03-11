import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/providers/raffle_id_provider.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';

final raffleProvider = Provider<Raffle>((ref) {
  final raffleId = ref.watch(raffleIdProvider);
  final raffleList = ref.watch(raffleListProvider);
  return raffleList.when(
    data: (raffleList) => raffleList.firstWhere(
        (raffle) => raffle.id == raffleId,
        orElse: () => Raffle.empty()),
    error: (error, stackTrace) => Raffle.empty(),
    loading: () => Raffle.empty(),
  );
});

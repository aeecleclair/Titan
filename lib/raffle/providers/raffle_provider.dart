import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/providers/raffle_id_provider.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';

final raffleProvider = Provider<Raffle>((ref) {
  final raffleId = ref.watch(raffleIdProvider);
  final raffleList = ref.watch(raffleListProvider);
  return raffleList.maybeWhen(
    data: (raffleList) => raffleList.firstWhere(
      (raffle) => raffle.id == raffleId,
      orElse: () => Raffle.empty(),
    ),
    orElse: () => Raffle.empty(),
  );
});

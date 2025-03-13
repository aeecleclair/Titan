import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/raffle/providers/raffle_id_provider.dart';
import 'package:myecl/raffle/providers/raffle_list_provider.dart';
import 'package:myecl/tools/builders/empty_models.dart';

final raffleProvider = Provider<RaffleComplete>((ref) {
  final raffleId = ref.watch(raffleIdProvider);
  final raffleList = ref.watch(raffleListProvider);
  return raffleList.maybeWhen(
    data: (raffleList) => raffleList.firstWhere(
      (raffle) => raffle.id == raffleId,
      orElse: () => EmptyModels.empty<RaffleComplete>(),
    ),
    orElse: () => EmptyModels.empty<RaffleComplete>(),
  );
});

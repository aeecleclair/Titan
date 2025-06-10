import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';

final raffleIdProvider = StateNotifierProvider<RaffleIdProvider, String>((ref) {
  final raffles = ref.watch(raffleListProvider);
  return raffles.maybeWhen(
    data: (data) => RaffleIdProvider(data.first.id),
    orElse: () => RaffleIdProvider(""),
  );
});

class RaffleIdProvider extends StateNotifier<String> {
  RaffleIdProvider(super.id);

  void setId(String i) {
    state = i;
  }
}

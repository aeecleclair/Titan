import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';

final raffleIdProvider =
    StateNotifierProvider<RaffleIdProvider, String>((ref) {
  final deliveries = ref.watch(raffleListProvider);
  return deliveries.when(
      data: (data) {
        return RaffleIdProvider(data.first.id);
      },
      error: (_, __) => RaffleIdProvider(""),
      loading: () => RaffleIdProvider(""));
});

class RaffleIdProvider extends StateNotifier<String> {
  RaffleIdProvider(String id) : super(id);

  void setId(String i) {
    state = i;
  }
}

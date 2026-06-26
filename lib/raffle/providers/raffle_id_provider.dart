import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';

final raffleIdProvider = NotifierProvider<RaffleIdProvider, String>(
  RaffleIdProvider.new,
);

class RaffleIdProvider extends Notifier<String> {
  @override
  String build() {
    final raffles = ref.watch(raffleListProvider);
    return raffles.maybeWhen(data: (data) => data.first.id, orElse: () => "");
  }

  void setId(String i) {
    state = i;
  }
}

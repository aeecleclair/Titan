import 'package:flutter_riverpod/flutter_riverpod.dart';

final raffleIdProvider =
    StateNotifierProvider<RaffleIdProvider, String>((ref) {
  return RaffleIdProvider("");
});

class RaffleIdProvider extends StateNotifier<String> {
  RaffleIdProvider(String id) : super(id);

  void setId(String i) {
    state = i;
  }
}

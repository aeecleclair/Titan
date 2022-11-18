import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsConnectedProvider extends StateNotifier<bool> {
  IsConnectedProvider() : super(false);

  Future isInternet() async {
    state = await DataConnectionChecker().hasConnection;
  }
}

final isConnectedProvider =
    StateNotifierProvider<IsConnectedProvider, bool>((ref) {
  final notifier = IsConnectedProvider();
  notifier.isInternet();
  return notifier;
});

import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsConnectedProvider extends StateNotifier<bool> {
  IsConnectedProvider() : super(false);

  Future isInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      state = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      state = false;
    }
  }
}

final isConnectedProvider =
    StateNotifierProvider<IsConnectedProvider, bool>((ref) {
  final notifier = IsConnectedProvider();
  notifier.isInternet();
  return notifier;
});

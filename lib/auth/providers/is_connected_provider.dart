import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/functions.dart';

class IsConnectedProvider extends StateNotifier<bool> {
  IsConnectedProvider() : super(false);

  Future isInternet() async {
    try {
      final result = await http.get(Uri.parse("${getTitanHost()}information"));
      state = result.statusCode < 400;
    } catch (e) {
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

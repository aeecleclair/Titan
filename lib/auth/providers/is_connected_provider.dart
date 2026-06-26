import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/functions.dart';

class IsConnectedProvider extends Notifier<bool> {
  @override
  bool build() {
    isInternet();
    return false;
  }

  Future isInternet() async {
    try {
      final result = await http.get(Uri.parse("${getTitanHost()}information"));
      state = result.statusCode < 400;
    } catch (e) {
      state = false;
    }
  }
}

final isConnectedProvider = NotifierProvider<IsConnectedProvider, bool>(
  IsConnectedProvider.new,
);

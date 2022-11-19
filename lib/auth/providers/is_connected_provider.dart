import 'dart:async';
import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
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

// class NetworkConnectivity {
//   NetworkConnectivity._();
//   static final _instance = NetworkConnectivity._();
//   static NetworkConnectivity get instance => _instance;
//   final _networkConnectivity = Connectivity();
//   final _controller = StreamController.broadcast();
//   Stream get myStream => _controller.stream;
//   void initialise() async {
//     ConnectivityResult result = await _networkConnectivity.checkConnectivity();
//     _checkStatus(result);
//     _networkConnectivity.onConnectivityChanged.listen((result) {
//       print(result);
//       _checkStatus(result);
//     });
//   }

//   void _checkStatus(ConnectivityResult result) async {
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//   }

//   void disposeStream() => _controller.close();
// }

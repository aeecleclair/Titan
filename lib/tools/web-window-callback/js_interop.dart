import 'dart:async';
import 'package:web/web.dart';
import 'dart:js_interop';

void webWindowWithCallback(
  String windowUrl,
  String windowName,
  void Function() completerFutureCallback,
  Future<void> Function(String) login,
) async {
  Window? popupWin = window.open(
    windowUrl,
    windowName,
    "width=800, height=900, scrollbars=yes",
  );

  final completer = Completer();
  void checkWindowClosed() {
    if (popupWin!.closed == true) {
      completer.complete();
    } else {
      Future.delayed(const Duration(milliseconds: 100), checkWindowClosed);
    }
  }

  checkWindowClosed();
  completer.future.then((_) => completerFutureCallback());

  window.onMessage.listen((event) {
    final data = (event.data as JSString).toDart;
    if (data.contains('code=')) {
      login(data);
      popupWin!.close();
    }
  });
}

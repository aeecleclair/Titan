import 'dart:async';

void webWindowWithCallback(
  String windowUrl,
  String windowName,
  void Function() completerFutureCallback,
  Future<void> Function(String) login,
) async {
  throw UnsupportedError(
    "`webWindowWithCallback()` is not implemented for the current platform",
  );
}

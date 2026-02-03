class Window {
  bool? closed() => throw UnsupportedError(
    "`closed` is not implemented for the current platform",
  );
  void close() => throw UnsupportedError(
    "`close()` is not implemented for the current platform",
  );
}

Window? open(String url, String target, String features) {
  throw UnsupportedError(
    "`window.open()` is not implemented for the current platform",
  );
}

dynamic listen(Function? onData) {
  throw UnsupportedError(
    "`window.onMessage.listen()` is not implemented for the current platform",
  );
}

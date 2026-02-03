import 'package:web/web.dart' as web;

class Window {
  bool? Function() closed;
  void Function() close;
  Window(bool? this.closed(), void this.close());
}

Window? open(String url, String target, String features) {
  var a = web.window.open(url, target, features);
  return a == null ? null : Window(() => a.closed, () => a.close());
}

dynamic listen(Function? onData) {
  return web.window.onMessage.listen(
    onData as void Function(web.MessageEvent)?,
  );
}

// dynamic window() {
//   print("En JS interop");
//   return web.window;
// }

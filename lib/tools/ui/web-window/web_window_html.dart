import 'package:universal_html/universal_html.dart' as web;

class Window {
  bool? closed() => web.window.closed;
  void close() => web.window.close();
}

Window? open(String url, String target, String features) {
  return web.window.open(url, target, features) as Window;
}

dynamic listen(Function? onData) {
  return web.window.onMessage.listen(
    onData as void Function(web.MessageEvent)?,
  );
}

// dynamic window() {
//   print("En HTML");
//   return web.window;
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends ConsumerWidget {
  const WebViewExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = QR.params['path'].toString();

    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: controller),
    );
  }
}

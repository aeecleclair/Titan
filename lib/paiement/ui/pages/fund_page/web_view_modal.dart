import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/providers/my_wallet_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends ConsumerWidget {
  final String url;
  const WebViewExample({super.key, required this.url});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (UrlChange change) {
            print(change.url);
            // if (request.url.toString().contains('code=')) {
            //   final receivedUri = Uri.parse(request.url);
            //   final code = receivedUri.queryParameters["code"];
            //   if (code == "succeeded") {
            //     displayToastWithContext(
            //       TypeMsg.msg,
            //       "Paiement effectué avec succès",
            //     );
            //     ref.watch(myWalletProvider.notifier).getMyWallet();
            //   } else {
            //     displayToastWithContext(TypeMsg.error, "Paiement annulé");
            //   }
            //   Navigator.pop(context);
            // }
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: controller),
    );
  }
}

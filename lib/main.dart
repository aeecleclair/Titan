import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/drawer/ui/app_drawer.dart';
import 'package:myecl/login/ui/auth.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final recievedUri = useState<String?>(null);
    final token = useState<String?>(null);

    useState<Stream<Uri?>>(uriLinkStream).value.listen((Uri? uri) {
      print(uri);
      recievedUri.value = uri.toString();
      token.value = uri?.queryParameters['token'];
      print(token.value);
    }, onError: (Object err) {
      recievedUri.value = 'Failed to get initial uri: $err.';
    });
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyECL',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.notoSerifMalayalamTextTheme(
                Theme.of(context).textTheme)),
        home: isLoggedIn ? const AppDrawer() : const AuthScreen());
  }
}

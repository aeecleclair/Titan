import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:myecl/drawer/ui/app_drawer.dart';
import 'package:myecl/login/ui/auth.dart';
import 'package:myecl/others/ui/no_internert_page.dart';
import 'package:myecl/others/ui/update_page.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recievedUri = useState<String?>(null);
    final token = useState<String?>(null);

    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);
    final check = versionVerifier.whenData(
        (value) => value.minimalTitanVersion.compareTo(titanVersion) <= 0);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    ref.watch(sectionProvider);

    // useState<Stream<Uri?>>(uriLinkStream).value.listen((Uri? uri) {
    //   recievedUri.value = uri.toString();
    //   token.value = uri?.queryParameters['token'];
    //   if (recievedUri.value != null) {}
    // }, onError: (Object err) {
    //   recievedUri.value = 'Failed to get initial uri: $err.';
    // });

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyECL',
        theme: ThemeData(
            primarySwatch: MaterialColor(4280360191, {
              50: Color(0xfff2f2f2),
              100: Color(0xffe6e6e6),
              200: Color(0xffcccccc),
              300: Color(0xffb3b3b3),
              350: Color(0xffaaaaaa),
              400: Color(0xff999999),
              500: Color(0xff808080),
              600: Color(0xff666666),
              700: Color(0xff4d4d4d),
              800: Color(0xff333333),
              850: Color(0xff262626),
              900: Color(0xff1a1a1a)
            }),
            textTheme: GoogleFonts.notoSerifMalayalamTextTheme(
                Theme.of(context).textTheme)),
        home: const SafeArea(child: AppDrawer()));
    // home: SafeArea(
    //   child: check.when(
    //       data: (value) => value
    //           ? isLoggedIn
    //               ? const AppDrawer()
    //               : const AuthScreen()
    //           : const UpdatePage(),
    //       loading: () => const Scaffold(
    //             body: Center(
    //               child: CircularProgressIndicator(),
    //             ),
    //           ),
    //       error: (error, stack) => const Scaffold(body: NoInternetPage())),
    // ));
  }
}

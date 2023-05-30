import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/router.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  AppRouter.configureRoutes(AppRouter.router);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyECL',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          textTheme: GoogleFonts.notoSerifMalayalamTextTheme(
              Theme.of(context).textTheme)),
      // home: check.when(
      //     data: (value) => value
      //         ? isLoggedIn
      //             ? const AppDrawer()
      //             : const AuthScreen()
      //         : const UpdatePage(),
      //     loading: () => const Scaffold(
      //           body: Center(
      //             child: CircularProgressIndicator(
      //               color: ColorConstants.gradient1,
      //             ),
      //           ),
      //         ),
      //     error: (error, stack) => const Scaffold(body: NoInternetPage())),
      onGenerateRoute: AppRouter.router.generator,
      initialRoute: '/',
      
    );
  }
}

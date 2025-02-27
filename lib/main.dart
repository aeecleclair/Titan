import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myecl/login/providers/animation_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/providers/top_bar_callback_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/router.dart';
import 'package:myecl/service/tools/setup.dart';
import 'package:myecl/tools/ui/layouts/app_template.dart';
import 'package:qlevar_router/qlevar_router.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  QR.setUrlStrategy();
  // We set the default page type to QMaterialPage
  // See https://pub.dev/packages/qlevar_router#page-transition
  // We should not use a combination of QMaterialPage and QCupertinoPage
  QR.settings.pagesType = const QMaterialPage();

  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final animationController =
        useAnimationController(duration: const Duration(seconds: 2));
    final animationNotifier = ref.read(backgroundAnimationProvider.notifier);
    final navigatorKey = GlobalKey<NavigatorState>();

    Future(() => animationNotifier.setController(animationController));

    final myWillPopScope = WillPopScope(
        onWillPop: () async {
          final topBarCallBack = ref.watch(topBarCallBackProvider);
          if (QR.currentPath.split('/').length <= 2) {
            final animation = ref.watch(animationProvider);
            if (animation != null) {
              final controller = ref.watch(swipeControllerProvider(animation));
              if (controller.isCompleted) {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              } else {
                final controllerNotifier =
                    ref.watch(swipeControllerProvider(animation).notifier);
                controllerNotifier.toggle();
                topBarCallBack.onMenu?.call();
              }
            }
            return false;
          }
          topBarCallBack.onBack?.call();
          return true;
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'MyECL',
          scrollBehavior: MyCustomScrollBehavior(),
          supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
              primarySwatch: Colors.orange,
              textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
              brightness: Brightness.light),
          routeInformationParser: const QRouteInformationParser(),
          builder: (context, child) {
            if (child == null) {
              return const SizedBox();
            }
            return AppTemplate(child: child);
          },
          routerDelegate: QRouterDelegate(
            appRouter.routes,
            initPath: AppRouter.root,
            navKey: navigatorKey,
          ),
        ));

    if (kIsWeb) {
      return myWillPopScope;
    }
    return MaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        home: myWillPopScope);
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus
      };
}

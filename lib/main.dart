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
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/plausible/plausible_observer.dart';
import 'package:myecl/tools/ui/layouts/app_template.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/tools/providers/theme_provider.dart';

void main() async {
  await dotenv.load();
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
    final plausible = getPlausible();
    Future(() => animationNotifier.setController(animationController));
    final isDarkTheme = ref.watch(themeProvider);

    final popScope = PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
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
          return;
        }
        QR.back();
        topBarCallBack.onBack?.call();
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
          brightness: Brightness.light,
          primarySwatch: Colors.orange,
          shadowColor: Colors.grey
              .withValues(alpha: 0.3), // to be used by default for shadows
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.white, // main color, mostly for background
            onPrimary: Colors.black, // for small things on primary
            secondary: Colors
                .black, // opposite of the primary, covering larger surface
            onSecondary: Colors.white, // for small things on secondary
            tertiary: Colors.grey, // between primary and secondary. Constant
            error: Colors.red, // self-explanatory. Constant
            onError:
                Colors.white, // white stands out well on red. Thus constant
            surface: Colors.white, // identical to primary
            onSurface: Colors.black, // identical to onPrimary
            primaryContainer: Color(
              0xFFfb6d10,
            ), // an actual color. For boxes, buttons, etc., to emphasize them. Formerly known as gradient1
            primaryFixed: Color(
              0xffeb3e1b,
            ), // formerly known as gradient2, used mainly for gradients. Slightly farther from primary
            onPrimaryContainer: Colors
                .white, // a color that stands out well on primaryContainer
            secondaryFixed:
                Color(0xFFDDDDDD), // for discrete shadows on primary
            secondaryContainer: Color(0xFF222222), // opposite of secondaryFixed
          ),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.black, displayColor: Colors.black),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange,
          shadowColor: Colors.grey.withValues(alpha: 0.7),
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.black,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.white,
            tertiary: Colors.grey,
            surface: Colors.black,
            onSurface: Colors.white,
            primaryContainer: Color(0xFFfb6d10),
            primaryFixed: Color(0xffeb3e1b),
            onPrimaryContainer: Colors.white,
            secondaryFixed: Color(0xFF222222),
            secondaryContainer: Color(0xFFDDDDDD),
          ),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white),
          ),
        ),
        themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        routeInformationParser: const QRouteInformationParser(),
        builder: (context, child) {
          if (child == null) {
            return const SizedBox();
          }
          return AppTemplate(child: child);
        },
        routerDelegate: QRouterDelegate(
          appRouter.routes,
          observers: [if (plausible != null) PlausibleObserver(plausible)],
          initPath: AppRouter.root,
          navKey: navigatorKey,
        ),
      ),
    );

    if (kIsWeb) {
      return popScope;
    }
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      home: popScope,
    );
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
        PointerDeviceKind.invertedStylus,
      };
}

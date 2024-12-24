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
        // Semantics of the colors
        //
        // `primary` is the ultimate background, hence the most prominent onscreen,
        // the theme is named after the "brightness" of `primary`.
        // There are 3 main colors, they strongly contrast with each other:
        // `secondary` is the opposite of `primary`;
        // `primaryContainer` is a true color (not some grayscale), a vivid one, to emphasize.
        // `secondary` and `primaryContainer` are for surfaces displayed on top of `primary`.
        // `surface` is identical to `primary`, in case a surface of this color is needed.
        //
        // `tertiary` is a blend of `primary` and `secondary`,
        // and in practice is it the same for both themes (and is seldom used, so far).
        // `error` is red in any case.
        // `primaryContainer` is defined to be close to `primarySwatch`,
        // which is outside of `colorScheme` and never written in code,
        // it is just to have a default non-grayscale color.
        // However `shadowColor` is written in code altough defined outside of `colorScheme`,
        // it is a translucent color, closer to `primary`, meant to be the default for shadows.
        //
        // Without the `on-` prefix, it is for surfaces (buttons, cards).
        // With `on-`, it is for things with no "thickness" (texts, icons, borders),
        // such that nothing could be displayed on top of them.
        // `onSomeColor` should be very legible on `someColor`,
        // so `onPrimaryContainer` and `onError` should be chosen carefully
        // since they do not have a natural opposite.
        // Meanwhile, the primary-secondary duality is still there with `on-`, thus:
        // `onSurface` = `onPrimary` := `secondary`, `onSecondary` := `primary`, etc.
        //
        // Likewise, the `-Fixed` suffix is for a less strong variant,
        // needed in some contexts (a discrete shadow, a minimal yet visible contrast),
        // hence `primaryFixed` and `secondaryFixed` are opposite.
        // `secondaryContainer` is to be understood as "primaryContainerFixed"
        // as it is actually a variant of `primaryContainer`,
        // slightly farther from `primary` and used mostly for gradients:
        // `primaryContainer` and `primaryFixed` are formerly known
        // as "gradient1" and "gradient2" here on Titan.
        //
        // LIST OF INCONSISTENCIES to fix (in that order):
        // Replace most `secondaryFixed` with `tertiary` (don't remember why, though)
        // Swap `primaryFixed` and `secondaryContainer`
        // Swap the `-Fixed`
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.orange,
          shadowColor: Colors.grey.withValues(alpha: 0.3),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.white,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSecondary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
            primaryContainer: Color(0xFFfb6d10),
            primaryFixed: Color(0xffeb3e1b),
            onPrimaryContainer: Colors.white,
            secondaryFixed: Color(0xFFDDDDDD),
            secondaryContainer: Color(0xFF222222),
            tertiary: Colors.grey,
            error: Colors.red,
            onError: Colors.white,
          ),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                ),
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
            surface: Colors.black,
            onSurface: Colors.white,
            primaryContainer: Color(0xFFfb6d10),
            primaryFixed: Color(0xffeb3e1b),
            onPrimaryContainer: Colors.white,
            secondaryFixed: Color(0xFF222222),
            secondaryContainer: Color(0xFFDDDDDD),
            error: Colors.red,
            onError: Colors.white,
            tertiary: Colors.grey,
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

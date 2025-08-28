import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/navigation/providers/navbar_animation.dart';
import 'package:titan/router.dart';
import 'package:titan/service/tools/setup.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/plausible/plausible_observer.dart';
import 'package:titan/tools/providers/locale_notifier.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/trads/en_timeago.dart';
import 'package:titan/tools/trads/fr_timeago.dart';
import 'package:titan/tools/ui/layouts/app_template.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:qlevar_router/qlevar_router.dart' as qqr;
import 'package:timeago/timeago.dart' as timeago;
import 'package:app_links/app_links.dart';

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
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  timeago.setLocaleMessages('fr', CustomFrMessages());
  timeago.setLocaleMessages('fr_short', CustomFrShortMessages());
  timeago.setLocaleMessages('en', CustomEnMessages());
  timeago.setLocaleMessages('en_short', CustomEnShortMessages());
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final navbarAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
      initialValue: 1.0,
    );
    final navbarAnimationNotifier = ref.read(navbarAnimationProvider.notifier);
    final navigatorKey = GlobalKey<NavigatorState>();
    final plausible = getPlausible();
    final pathForwardingNotifier = ref.watch(pathForwardingProvider.notifier);
    Future(
      () => navbarAnimationNotifier.setController(navbarAnimationController),
    );

    if (!kIsWeb) {
      useEffect(() {
        final appLinks = AppLinks();

        Future<void> initDeepLinks() async {
          try {
            appLinks.uriLinkStream.listen((Uri? uri) {
              if (uri != null) {
                final Map<String, String> queryParams = uri.queryParameters;

                final newPath = "/${uri.host}";
                pathForwardingNotifier.forward(
                  newPath,
                  queryParameters: queryParams,
                );
                QR.toName(newPath);
              }
            });
          } catch (err) {
            displayToast(
              context,
              TypeMsg.error,
              "Failed to listen to deep link: $err",
            );
          }
        }

        initDeepLinks();
        return null;
      }, []);
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: getAppName(),
      scrollBehavior: MyCustomScrollBehavior(),
      locale: ref.watch(localeProvider),
      supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        brightness: Brightness.light,
      ),
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

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:titan/login/providers/animation_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:titan/drawer/providers/animation_provider.dart';
import 'package:titan/drawer/providers/swipe_provider.dart';
import 'package:titan/drawer/providers/top_bar_callback_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/router.dart';
import 'package:titan/service/tools/setup.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/plausible/plausible_observer.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
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
  timeago.setLocaleMessages('fr', timeago.FrMessages());
  timeago.setLocaleMessages('fr_short', timeago.FrShortMessages());
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    );
    final animationNotifier = ref.read(backgroundAnimationProvider.notifier);
    final navigatorKey = GlobalKey<NavigatorState>();
    final plausible = getPlausible();
    final pathForwardingNotifier = ref.watch(pathForwardingProvider.notifier);
    Future(() => animationNotifier.setController(animationController));

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

    final popScope = PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        final topBarCallBack = ref.watch(topBarCallBackProvider);
        if (QR.currentPath.split('/').length <= 2) {
          final animation = ref.watch(animationProvider);
          if (animation != null) {
            final controller = ref.watch(swipeControllerProvider(animation));
            if (controller.isCompleted) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            } else {
              final controllerNotifier = ref.watch(
                swipeControllerProvider(animation).notifier,
              );
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
          primarySwatch: Colors.orange,
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
      ),
    );
    return popScope;
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

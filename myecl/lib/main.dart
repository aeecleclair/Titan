import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/ui/app_drawer.dart';
import 'package:myecl/login/ui/auth.dart';
import 'package:myecl/user/providers/auth_token_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authTokenProvider.notifier);
    auth.getTokenFromStorage();
    auth.shouldRefreshToken();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyECL',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: auth.isLoggedIn
        ? const AppDrawer()
        : const AuthScreen());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/providers/user_list_provider.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var test = ref.watch(userList);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: test.when(
        data: (test) {
          return Scaffold(
            body: Center(
              child: Column(
                children: test.map((e) => Text(e.nickname)).toList()),
            )
          );
        },
        error: (error, stack) {
          return Scaffold(
            body: Center(
              child: Text(error.toString()),
            ),
          );
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

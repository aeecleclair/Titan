import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/loader.dart';

class AsyncChild<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(BuildContext context, T value) builder;
  final Widget Function(Object? error, StackTrace? stack)? errorBuilder;
  final Color? loaderColor;
  const AsyncChild(
      {super.key,
      required this.value,
      required this.builder,
      this.errorBuilder,
      this.loaderColor});

  @override
  Widget build(BuildContext context) {
    return value.when(
        data: (value) => builder(context, value),
        loading: () => Loader(color: loaderColor),
        error: (error, stack) => errorBuilder != null
            ? errorBuilder!(error, stack)
            : Center(
                child: Text("${TextConstants.error}:$error"),
              ));
  }
}

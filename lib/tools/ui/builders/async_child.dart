import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/loader.dart';

class AsyncChild<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(BuildContext context, T value) builder;
  final Widget Function(Object? error, StackTrace? stack)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, Widget child)? orElseBuilder;
  final Color? loaderColor;
  const AsyncChild({
    super.key,
    required this.value,
    required this.builder,
    this.errorBuilder,
    this.loaderColor,
    this.orElseBuilder,
    this.loadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final nonNullOrElseBuilder = orElseBuilder ?? (context, child) => child;
    final nonNullLoadingBuilder =
        loadingBuilder ?? (context) => Loader(color: loaderColor);
    final nonNullErrorBuilder = errorBuilder ??
        (error, stack) => Center(
              child: Text(
                "${TextConstants.error}:$error",
                style: TextStyle(color: loaderColor),
              ),
            );
    return value.when(
      data: (value) => builder(context, value),
      loading: () =>
          nonNullOrElseBuilder(context, nonNullLoadingBuilder(context)),
      error: (error, stack) =>
          nonNullOrElseBuilder(context, nonNullErrorBuilder(error, stack)),
    );
  }
}

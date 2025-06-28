import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/loader.dart';
import 'package:tuple/tuple.dart';

class AsyncChild<P> extends StatelessWidget {
  final AsyncValue<P> value;
  final Widget Function(BuildContext context, P value) builder;
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
    final nonNullErrorBuilder =
        errorBuilder ??
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

Widget handleLoadingAndError(
  List<AsyncValue> values,
  BuildContext context, {
  Widget Function(BuildContext context)? loadingBuilder,
  Widget Function(Object? error, StackTrace? stack)? errorBuilder,
  Widget Function(BuildContext context, Widget child)? orElseBuilder,
  Color? loaderColor,
}) {
  final nonNullOrElseBuilder = orElseBuilder ?? (context, child) => child;
  final nonNullLoadingBuilder =
      loadingBuilder ?? (context) => Loader(color: loaderColor);
  final nonNullErrorBuilder =
      errorBuilder ??
      (error, stack) => Center(
        child: Text(
          "${TextConstants.error}:$error",
          style: TextStyle(color: loaderColor),
        ),
      );
  if (values.any((test) => test.hasError)) {
    final firstError = values.firstWhere((test) => test.hasError);
    final error = firstError.error;
    final stackTrace = firstError.stackTrace;
    return nonNullOrElseBuilder(
      context,
      nonNullErrorBuilder(error, stackTrace),
    );
  }
  if (values.any((test) => test.isLoading)) {
    return nonNullOrElseBuilder(context, nonNullLoadingBuilder(context));
  }
  return nonNullOrElseBuilder(context, const SizedBox.shrink());
}

class Async2Child<P, Q> extends StatelessWidget {
  final Tuple2<AsyncValue<P>, AsyncValue<Q>> values;
  final Widget Function(BuildContext context, P values1, Q values2) builder;
  final Widget Function(Object? error, StackTrace? stack)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, Widget child)? orElseBuilder;
  final Color? loaderColor;
  const Async2Child({
    super.key,
    required this.values,
    required this.builder,
    this.errorBuilder,
    this.loaderColor,
    this.orElseBuilder,
    this.loadingBuilder,
  });
  @override
  Widget build(BuildContext context) {
    List<AsyncValue> listValues = [values.item1, values.item2];
    if (listValues.any((test) => test.hasError) ||
        listValues.any((test) => test.isLoading)) {
      return handleLoadingAndError(
        listValues,
        context,
        loadingBuilder: loadingBuilder,
        errorBuilder: errorBuilder,
        orElseBuilder: orElseBuilder,
        loaderColor: loaderColor,
      );
    }
    return builder(context, listValues[0].value as P, listValues[1].value as Q);
  }
}

class Async3Child<P, Q, R> extends StatelessWidget {
  final Tuple3<AsyncValue<P>, AsyncValue<Q>, AsyncValue<R>> values;
  final Widget Function(BuildContext context, P values1, Q values2, R value3)
  builder;
  final Widget Function(Object? error, StackTrace? stack)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, Widget child)? orElseBuilder;
  final Color? loaderColor;
  const Async3Child({
    super.key,
    required this.values,
    required this.builder,
    this.errorBuilder,
    this.loaderColor,
    this.orElseBuilder,
    this.loadingBuilder,
  });
  @override
  Widget build(BuildContext context) {
    List<AsyncValue> listValues = [values.item1, values.item2, values.item3];
    if (listValues.any((test) => test.hasError) ||
        listValues.any((test) => test.isLoading)) {
      return handleLoadingAndError(
        listValues,
        context,
        loadingBuilder: loadingBuilder,
        errorBuilder: errorBuilder,
        orElseBuilder: orElseBuilder,
        loaderColor: loaderColor,
      );
    }
    return builder(
      context,
      listValues[0].value as P,
      listValues[1].value as Q,
      listValues[2].value as R,
    );
  }
}

class Async4Child<P, Q, R, S> extends StatelessWidget {
  final Tuple4<AsyncValue<P>, AsyncValue<Q>, AsyncValue<R>, AsyncValue<S>>
  values;
  final Widget Function(
    BuildContext context,
    P values1,
    Q value2,
    R values3,
    S value4,
  )
  builder;
  final Widget Function(Object? error, StackTrace? stack)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, Widget child)? orElseBuilder;
  final Color? loaderColor;
  const Async4Child({
    super.key,
    required this.values,
    required this.builder,
    this.errorBuilder,
    this.loaderColor,
    this.orElseBuilder,
    this.loadingBuilder,
  });
  @override
  Widget build(BuildContext context) {
    List<AsyncValue> listValues = [values.item1, values.item2, values.item3];
    if (listValues.any((test) => test.hasError) ||
        listValues.any((test) => test.isLoading)) {
      return handleLoadingAndError(
        listValues,
        context,
        loadingBuilder: loadingBuilder,
        errorBuilder: errorBuilder,
        orElseBuilder: orElseBuilder,
        loaderColor: loaderColor,
      );
    }
    return builder(
      context,
      listValues[0].value as P,
      listValues[1].value as Q,
      listValues[2].value as R,
      listValues[3].value as S,
    );
  }
}

class Async5Child<P, Q, R, S, T> extends StatelessWidget {
  final Tuple5<
    AsyncValue<P>,
    AsyncValue<Q>,
    AsyncValue<R>,
    AsyncValue<S>,
    AsyncValue<T>
  >
  values;
  final Widget Function(
    BuildContext context,
    P values1,
    Q value2,
    R values3,
    S value4,
    T value5,
  )
  builder;
  final Widget Function(Object? error, StackTrace? stack)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, Widget child)? orElseBuilder;
  final Color? loaderColor;
  const Async5Child({
    super.key,
    required this.values,
    required this.builder,
    this.errorBuilder,
    this.loaderColor,
    this.orElseBuilder,
    this.loadingBuilder,
  });
  @override
  Widget build(BuildContext context) {
    List<AsyncValue> listValues = [
      values.item1,
      values.item2,
      values.item3,
      values.item4,
      values.item5,
    ];
    if (listValues.any((test) => test.hasError) ||
        listValues.any((test) => test.isLoading)) {
      return handleLoadingAndError(
        listValues,
        context,
        loadingBuilder: loadingBuilder,
        errorBuilder: errorBuilder,
        orElseBuilder: orElseBuilder,
        loaderColor: loaderColor,
      );
    }
    return builder(
      context,
      listValues[0].value as P,
      listValues[1].value as Q,
      listValues[2].value as R,
      listValues[3].value as S,
      listValues[4].value as T,
    );
  }
}

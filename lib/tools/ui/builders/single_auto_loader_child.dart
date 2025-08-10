import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/providers/single_map_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/loader.dart';

class SingleAutoLoaderChild<T, E> extends ConsumerWidget {
  final AsyncValue<E>? item;
  final SingleMapNotifier<T, E> notifier;
  final T mapKey;
  final Future<AsyncValue<E>> Function(T t) loader;
  final Widget Function(BuildContext context, E value) dataBuilder;
  final Widget Function(Object? error, StackTrace? stack)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, Widget child)? orElseBuilder;
  final Color? loaderColor;

  const SingleAutoLoaderChild({
    super.key,
    required this.item,
    required this.notifier,
    required this.mapKey,
    required this.loader,
    required this.dataBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.orElseBuilder,
    this.loaderColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nonNullLoadingBuilder =
        loadingBuilder ?? (context) => Loader(color: loaderColor);
    if (item == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.autoLoad(ref, mapKey, loader);
      });
      return nonNullLoadingBuilder(context);
    }
    return AsyncChild(
      value: item!,
      builder: (context, value) {
        return dataBuilder(context, value);
      },
      loaderColor: loaderColor,
    );
  }
}

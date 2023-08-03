import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/loader.dart';

class AutoLoaderChild<MapKey, MapValue> extends ConsumerWidget {
  final AsyncValue<Map<MapKey, AsyncValue<List<MapValue>>>> value;
  final MapNotifier<MapKey, MapValue> notifier;
  final MapKey mapKey;
  final Future<MapValue> Function(MapKey t) loader;
  final Widget Function(BuildContext context, MapValue value) dataBuilder;
  final Widget Function(Object? error, StackTrace? stack)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, Widget child)? orElseBuilder;
  final Color? loaderColor;
  const AutoLoaderChild(
      {super.key,
      required this.value,
      required this.notifier,
      required this.mapKey,
      required this.loader,
      required this.dataBuilder,
      this.errorBuilder,
      this.loaderColor,
      this.orElseBuilder,
      this.loadingBuilder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nonNullLoadingBuilder =
        loadingBuilder ?? (context) => Loader(color: loaderColor);
    return AsyncChild(
        value: value,
        builder: (context, value) {
          final group = value[mapKey];
          if (group == null) {
            notifier.autoLoad(ref, mapKey, loader);
            return nonNullLoadingBuilder(context);
          }
          return AsyncChild(
              value: group,
              builder: (context, list) {
                if (list.isEmpty) {
                  notifier.autoLoad(ref, mapKey, loader);
                  return nonNullLoadingBuilder(context);
                }
                return dataBuilder(context, list.first);
              },
              orElseBuilder: orElseBuilder,
              errorBuilder: errorBuilder,
              loadingBuilder: loadingBuilder,
              loaderColor: loaderColor);
        },
        orElseBuilder: orElseBuilder,
        errorBuilder: errorBuilder,
        loadingBuilder: loadingBuilder,
        loaderColor: loaderColor);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AdminScrollChips<T> extends HookWidget {
  final bool isEdit;
  final List<T> data;
  final GlobalKey dataKey;
  final String pageStorageKeyName;
  final Widget Function(T) builder;

  const AdminScrollChips({
    super.key,
    required this.isEdit,
    required this.dataKey,
    required this.data,
    required this.pageStorageKeyName,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (isEdit) {
      useEffect(() {
        Future(
          () => Scrollable.ensureVisible(
            dataKey.currentContext!,
            duration: const Duration(milliseconds: 500),
            alignment: 0.5,
          ),
        );
        return;
      }, []);
    }
    return SingleChildScrollView(
      key: PageStorageKey(pageStorageKeyName),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 15),
          ...data.map((e) => builder(e)),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

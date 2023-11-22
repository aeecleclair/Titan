import 'package:flutter/material.dart';

class AdminScrollChips<T> extends StatefulWidget {
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
  State<AdminScrollChips<T>> createState() => _AdminScrollChipsState<T>();
}

class _AdminScrollChipsState<T> extends State<AdminScrollChips<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      Future(
        () => Scrollable.ensureVisible(
          widget.dataKey.currentContext!,
          duration: const Duration(milliseconds: 500),
          alignment: 0.5,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: PageStorageKey(widget.pageStorageKeyName),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 15),
          ...widget.data.map((e) => widget.builder(e)),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

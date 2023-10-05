import 'package:flutter/material.dart';

class AdminScrollChips<T> extends StatelessWidget {
  final bool isEdit;
  final List<T> data;
  final GlobalKey dataKey;
  final String pageStorageKeyName;
  final Widget Function(T) builder;

  AdminScrollChips({
    super.key,
    required this.isEdit,
    required this.dataKey,
    required this.data,
    required this.pageStorageKeyName,
    required this.builder,
  }) {
    if (isEdit) {
      Future(
        () => Scrollable.ensureVisible(
          dataKey.currentContext!,
          duration: const Duration(milliseconds: 500),
          alignment: 0.5,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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

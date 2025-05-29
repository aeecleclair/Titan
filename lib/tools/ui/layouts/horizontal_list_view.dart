import 'package:flutter/material.dart';

class HorizontalListView<T> extends StatelessWidget {
  final List<T>? items;
  final Widget Function(BuildContext context, T item, int i)? itemBuilder;
  final List<Widget>? children;
  final double? horizontalSpace;
  final double height;
  final int? length;
  final Widget childDelegate;
  final Widget? firstChild;
  final Widget? lastChild;
  final ScrollController? scrollController;

  HorizontalListView({
    super.key,
    required this.height,
    this.children,
    this.scrollController,
  }) : assert(children != null),
       items = null,
       itemBuilder = null,
       horizontalSpace = null,
       length = null,
       firstChild = null,
       lastChild = null,
       childDelegate = SingleChildScrollView(
         scrollDirection: Axis.horizontal,
         clipBehavior: Clip.none,
         controller: scrollController,
         physics: const BouncingScrollPhysics(),
         child: Row(children: children!),
       );

  HorizontalListView.builder({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.height,
    this.length,
    this.firstChild,
    this.lastChild,
    this.scrollController,
    this.horizontalSpace = 15,
  }) : assert(itemBuilder != null),
       assert(items != null),
       children = null,
       childDelegate = ListView.builder(
         scrollDirection: Axis.horizontal,
         clipBehavior: Clip.none,
         controller: scrollController,
         physics: const BouncingScrollPhysics(),
         itemCount:
             (length ?? items!.length) +
             2 +
             (firstChild != null ? 1 : 0) +
             (lastChild != null ? 1 : 0),
         itemBuilder: (context, index) {
           if (index == 0 ||
               index ==
                   items!.length +
                       1 +
                       (firstChild != null ? 1 : 0) +
                       (lastChild != null ? 1 : 0)) {
             return SizedBox(width: horizontalSpace);
           }
           if (index == 1 && firstChild != null) {
             return firstChild;
           }
           if (index == items.length + (firstChild != null ? 1 : 0) + 1 &&
               lastChild != null) {
             return lastChild;
           }
           return itemBuilder?.call(
             context,
             items[index - 1 - (firstChild != null ? 1 : 0)],
             index - 1 - (firstChild != null ? 1 : 0),
           );
         },
       );

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, child: childDelegate);
  }
}

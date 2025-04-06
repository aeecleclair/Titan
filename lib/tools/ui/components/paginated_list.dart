import 'package:flutter/material.dart';

class PaginatedList<T> extends StatelessWidget {
  final List<T> items;
  final Future<void> Function() onRefresh;
  final VoidCallback loadMore;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final int extraItemCount; // Typically 1 for loading indicator

  const PaginatedList({
    super.key,
    required this.items,
    required this.onRefresh,
    required this.loadMore,
    required this.itemBuilder,
    this.extraItemCount = 1,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels >=
              scrollNotification.metrics.maxScrollExtent - 100) {
            loadMore();
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < items.length) {
                    return itemBuilder(context, items[index]);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
                childCount: items.length + extraItemCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

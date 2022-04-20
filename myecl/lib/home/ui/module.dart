import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/home/class/module.dart';
import 'package:myecl/home/providers/page_provider.dart';

class ModuleUI extends ConsumerWidget {
  final Module m;
  const ModuleUI({Key? key, required this.m}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(pageProvider);
    final pageNotifier = ref.watch(pageProvider.notifier);
    return GestureDetector(
      key: ValueKey(m.pos),
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        width: 220,
        color: Colors.grey.withOpacity(0.001),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 25,
                ),
                SizedBox(
                    height: 50,
                    child: Center(
                        child: Icon(
                      m.icon,
                      color: m.pos == page
                          ? Colors.grey.shade100
                          : Colors.grey.shade100.withOpacity(0.6),
                    ))),
                Container(
                  width: 20,
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      m.name,
                      style: TextStyle(
                        color: m.pos == page
                            ? Colors.grey.shade100
                            : Colors.grey.shade100.withOpacity(0.6),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        pageNotifier.setPage(m.pos);
      },
      onDoubleTap: () {
        pageNotifier.setPage(m.pos);
        // widget.toggle();
      },
    );
  }
}

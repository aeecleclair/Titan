import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/home/providers/today_provider.dart';

class CurrentTime extends ConsumerWidget {
  const CurrentTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(nowProvider);
    return Positioned(
      top: (today.hour + today.minute / 60 + today.second / 3600) * 90.0 - 6,
      left: 0,
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Container(
            height: 3,
            width: 500,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

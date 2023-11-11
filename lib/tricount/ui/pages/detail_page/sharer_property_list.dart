import 'package:flutter/material.dart';

class SharerPropertyList<T> extends StatelessWidget {
  final List<T> propertyList;
  final String title;
  final Widget Function(T) builder;
  const SharerPropertyList(
      {super.key,
      required this.propertyList,
      required this.builder,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 30,
          child: Text(
            title,
            style: const TextStyle(color: Color(0xff09263D), fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        ...propertyList.map((e) => builder(e))
      ]),
    );
  }
}

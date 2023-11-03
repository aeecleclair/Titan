import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class SharerPropertyList<T> extends StatelessWidget {
  final List<T> propertyList;
  final String title;
  final Widget Function(T) builder;
  final void Function()? onTap;
  const SharerPropertyList(
      {super.key,
      required this.propertyList,
      required this.builder,
      required this.title,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(color: Color(0xff09263D), fontSize: 20),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: const HeroIcon(
                HeroIcons.plus,
                color: Color(0xff09263D),
                size: 30,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        ...propertyList.map((e) => builder(e))
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/sdec/tools/constants.dart';
import 'package:myecl/sdec/ui/sdec.dart';

class DescriptionPage extends HookConsumerWidget {
  final Color? color;
  final List<Color>? colors;
  const DescriptionPage({
    super.key,
    this.color = const Color.fromARGB(255, 0, 175, 15),
    this.colors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useColors = colors != null;
    return SDeCTemplate(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
                padding: const EdgeInsets.only(bottom: 30, left: 20, right: 30),
                child: Column(children: [
                  const SizedBox(height: 40),
                  Container(
                      height: 70,
                      decoration: BoxDecoration(
                          gradient: useColors
                              ? RadialGradient(
                                  colors: colors!,
                                  center: Alignment.topLeft,
                                  radius: 2,
                                )
                              : null,
                          color: color,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: (useColors ? colors!.last : color)!
                                    .withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5))
                          ]),
                      child: const FractionallySizedBox(
                          widthFactor: 0.5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(SDeCTextConstants.descriptionsdec,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white))
                                ]),
                          ))),
                  const SizedBox(height: 40),
                ]))));
  }
}

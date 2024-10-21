import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/sdec/tools/constants.dart';
import 'package:myecl/sdec/ui/sdec.dart';
import 'package:myecl/sdec/router.dart';

class PresentationPage extends HookConsumerWidget {
  const PresentationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SDeCTemplate(
        root: SdecRouter.root,
        road: "Présentation",
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 30),
            child: const Column(children: [
              SizedBox(height: 30),
              PresentationPageText(text: SDeCTextConstants.description1),
              SizedBox(height: 10),
              PresentationPageContainer(
                  text: SDeCTextConstants.descriptionsdec),
              SizedBox(height: 10),
              PresentationPageText(text: SDeCTextConstants.description2),
              SizedBox(height: 10),
              PresentationPageContainer(text: SDeCTextConstants.produits),
              SizedBox(height: 10),
              PresentationPageText(text: SDeCTextConstants.description3),
              SizedBox(height: 10),
              PresentationPageContainer(text: SDeCTextConstants.simulation),
              SizedBox(height: 10),
              PresentationPageText(text: SDeCTextConstants.description4),
              SizedBox(height: 10),
              PresentationPageContainer(text: SDeCTextConstants.services),
              SizedBox(height: 10),
              PresentationPageText(text: SDeCTextConstants.description5),
            ]),
          ),
        ));
  }
}

class PresentationPageContainer extends HookConsumerWidget {
  final Color? color;
  final List<Color>? colors;
  final String text;
  const PresentationPageContainer({
    super.key,
    this.color = const Color.fromARGB(255, 0, 175, 15),
    this.colors,
    this.text = "",
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useColors = colors != null;
    return Container(
        height: 40,
        decoration: BoxDecoration(
            gradient: useColors
                ? RadialGradient(
                    colors: colors!,
                    center: Alignment.topLeft,
                    radius: 2,
                  )
                : null,
            color: color,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: (useColors ? colors!.last : color)!.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5))
            ]),
        child: FractionallySizedBox(
            widthFactor: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white))
              ]),
            )));
  }
}

class PresentationPageText extends HookConsumerWidget {
  final String text;
  const PresentationPageText({
    super.key,
    this.text = '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: text,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              foreground: Paint()
                ..shader = const RadialGradient(
                  colors: [Colors.brown, Colors.green],
                  center: Alignment.topCenter,
                  radius: 10,
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
        ));
  }
}

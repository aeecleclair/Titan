import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/sdec/router.dart';
import 'package:myecl/sdec/ui/sdec.dart';
import 'package:myecl/sdec/tools/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SdecMainPage extends HookConsumerWidget {
  final Color? color;
  final List<Color>? colors;
  const SdecMainPage(
      {super.key,
      this.color = const Color.fromARGB(255, 0, 175, 15),
      this.colors});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SDeCTemplate(
        root: SdecRouter.root,
        road: "",
        child: Column(children: [
          SizedBox(height: 40),
          SdecContainer(
            text: SDeCTextConstants.descriptionsdec,
            route: SdecRouter.description,
          ),
          SizedBox(height: 40),
          SdecContainer(
            text: SDeCTextConstants.produits,
            route: SdecRouter.description,
          ),
          SizedBox(height: 40),
          SdecContainer(
            text: SDeCTextConstants.simulation,
            route: SdecRouter.description,
          ),
          SizedBox(height: 40),
          SdecContainer(
            text: SDeCTextConstants.services,
            route: SdecRouter.presentation,
          ),
        ]));
  }
}

class SdecContainer extends HookConsumerWidget {
  final Color? color;
  final List<Color>? colors;
  final String text;
  final String route;
  const SdecContainer({
    super.key,
    this.color = const Color.fromARGB(255, 0, 175, 15),
    this.colors,
    this.text = '',
    this.route = '',
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useColors = colors != null;
    return GestureDetector(
        onTap: () {
          QR.to(SdecRouter.root + route);
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
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
              child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white))
                        ]),
                  ))),
        ));
  }
}

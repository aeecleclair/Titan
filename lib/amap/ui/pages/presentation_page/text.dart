import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/information_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:url_launcher/url_launcher.dart';

class PresentationPage extends HookConsumerWidget {
  const PresentationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final information = ref.watch(informationProvider);
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(bottom: 30, left: 20, right: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: AMAPTextConstants.presentation1,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      foreground: Paint()
                        ..shader = const RadialGradient(
                          colors: [
                            AMAPColorConstants.greenGradient1,
                            AMAPColorConstants.textDark,
                          ],
                          center: Alignment.topLeft,
                          radius: 10,
                        ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                ),
                information.when(
                  data: (info) => TextSpan(
                      text: info.lien,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          try {
                            await launchUrl(Uri.parse(info.lien));
                          } catch (e) {
                            displayToast(context, TypeMsg.msg,
                                AMAPTextConstants.errorLink);
                          }
                        }),
                  error: (Object error, StackTrace stackTrace) {
                    return const TextSpan(
                        text: AMAPTextConstants.loadingError,
                        style: TextStyle(color: Colors.red));
                  },
                  loading: () {
                    return const TextSpan(
                        text: AMAPTextConstants.loading,
                        style: TextStyle(color: Colors.red));
                  },
                ),
                TextSpan(
                  text: AMAPTextConstants.presentation2,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      foreground: Paint()
                        ..shader = const RadialGradient(
                          colors: [
                            AMAPColorConstants.greenGradient1,
                            AMAPColorConstants.textDark,
                          ],
                          center: Alignment.topLeft,
                          radius: 10,
                        ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                )
              ])),
              Container(
                height: 15,
              ),
              information.when(
                data: (info) => Text(
                  "${AMAPTextConstants.contact} : ${info.respo}	",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AMAPColorConstants.textDark),
                ),
                error: (Object error, StackTrace stackTrace) {
                  return const Text(AMAPTextConstants.loadingError,
                      style: TextStyle(color: Colors.red));
                },
                loading: () {
                  return const Text(AMAPTextConstants.loading,
                      style: TextStyle(color: Colors.red));
                },
              )
            ],
          ),
        ));
  }
}

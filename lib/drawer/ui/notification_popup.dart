import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/display_notification_popup.dart';
import 'package:myecl/service/class/topic.dart';
import 'package:myecl/service/providers/topic_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double avatarRadius = 50.0;
  static const String title = 'Notifications';
  static const String description =
      "MyECL propose désormais des notifications que vous pouvez activer dès maintenant.\nVous pourrez toujours modifier votre choix dans les paramètres.";
  static const String button = 'Valider';
}

class NotificationPopup extends HookConsumerWidget {
  const NotificationPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(topicsProvider);
    final topicsNotifier = ref.read(topicsProvider.notifier);
    final displayNotificationPopupNotifier =
        ref.watch(displayNotificationPopupProvider.notifier);
    final animation = useAnimationController(
        duration: const Duration(milliseconds: 500), initialValue: 0);
    final curvedAnimation =
        CurvedAnimation(parent: animation, curve: Curves.easeInOut);

    final selectedTopic = topics.maybeWhen(
        data: (data) {
          return data;
        },
        orElse: () => []);
    return GestureDetector(
        onTap: displayNotificationPopupNotifier.setDisplay,
        child: Container(
          color: Colors.black54,
          child: GestureDetector(
            onTap: () {},
            child: Dialog(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Consts.padding))),
                elevation: 0.0,
                insetPadding: const EdgeInsets.all(Consts.padding),
                backgroundColor: Colors.transparent,
                child: Stack(clipBehavior: Clip.none, children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: Consts.avatarRadius + Consts.padding,
                      bottom: Consts.padding,
                      left: Consts.padding,
                      right: Consts.padding,
                    ),
                    margin: const EdgeInsets.only(top: Consts.avatarRadius),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(Consts.padding),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          Consts.title,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.background2,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        const Text(Consts.description,
                            textAlign: TextAlign.justify),
                        const SizedBox(height: 20.0),
                        Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: Topic.values
                                .map((e) => GestureDetector(
                                      onTap: () async {
                                        animation.forward(from: 0);
                                        await topicsNotifier
                                            .fakeToggleSubscription(e);
                                      },
                                      child: Container(
                                        width: 130,
                                        height: 60,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: selectedTopic.contains(e)
                                              ? ColorConstants.gradient1
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: selectedTopic.contains(e)
                                                  ? ColorConstants.gradient1
                                                  : Colors.black,
                                              width: 2.0),
                                        ),
                                        alignment: Alignment.center,
                                        child: AutoSizeText(capitalize(e.name),
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: selectedTopic.contains(e)
                                                    ? Colors.white
                                                    : Colors.black)),
                                      ),
                                    ))
                                .toList()),
                        const SizedBox(height: 40.0),
                        ShrinkButton(
                          onTap: () async {
                            displayNotificationPopupNotifier.setDisplay();
                            await topicsNotifier.subscribeAll();
                          },
                          waitChild: Container(
                              width: 130,
                              height: 60,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: ColorConstants.gradient1,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: ColorConstants.gradient1,
                                    width: 2.0),
                              ),
                              alignment: Alignment.center,
                              child: const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )),
                          child: Container(
                            width: 130,
                            height: 60,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: ColorConstants.gradient1,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: ColorConstants.gradient1, width: 2.0),
                            ),
                            alignment: Alignment.center,
                            child: const AutoSizeText(Consts.button,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      left: Consts.padding,
                      right: Consts.padding,
                      child: Container(
                          width: Consts.avatarRadius * 2,
                          height: Consts.avatarRadius * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                ColorConstants.gradient1,
                                ColorConstants.gradient2,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorConstants.gradient2.withOpacity(0.3),
                                blurRadius: 10.0,
                                offset: const Offset(0.0, 10.0),
                              ),
                            ],
                          ),
                          child: AnimatedBuilder(
                            animation: curvedAnimation,
                            builder: (context, animation) {
                              return Center(
                                  child: Badge(
                                backgroundColor: Colors.white,
                                label: Text(
                                  selectedTopic.length.toString(),
                                  style: const TextStyle(
                                      color: ColorConstants.gradient1,
                                      fontWeight: FontWeight.bold),
                                ),
                                child: Transform.rotate(
                                  origin: const Offset(0, -20),
                                  // Bounce
                                  angle:
                                      sin(curvedAnimation.value * pi * 2) * 0.2,
                                  child: const HeroIcon(
                                    HeroIcons.bell,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                              ));
                            },
                          ))),
                ])),
          ),
        ));
  }
}

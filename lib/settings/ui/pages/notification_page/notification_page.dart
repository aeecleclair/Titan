import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:load_switch/load_switch.dart';
import 'package:myecl/service/class/topic.dart';
import 'package:myecl/service/providers/topic_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/settings.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/refresher.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(topicsProvider);
    final topicsNotifier = ref.read(topicsProvider.notifier);
    return SettingsTemplate(
      child: Refresher(
          onRefresh: () async {
            await topicsNotifier.getTopics();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(SettingsTextConstants.updateNotification,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149))),
              ),
              const SizedBox(
                height: 30,
              ),
              topics.when(
                data: (g) => Column(
                    children: Topic.values
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(capitalize(e.name),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstants.background2)),
                                  LoadSwitch(
                                    value: g.contains(e),
                                    future: () =>
                                        topicsNotifier.toggleSubscription(e),
                                    height: 30,
                                    width: 60,
                                    curveIn: Curves.easeInBack,
                                    curveOut: Curves.easeOutBack,
                                    animationDuration:
                                        const Duration(milliseconds: 500),
                                    switchDecoration: (value) => BoxDecoration(
                                      color: value
                                          ? ColorConstants.gradient1
                                              .withOpacity(0.3)
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(30),
                                      shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: value
                                              ? ColorConstants.gradient1
                                                  .withOpacity(0.2)
                                              : Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    spinColor: (value) => value
                                              ? ColorConstants.gradient1
                                              : Colors.grey,
                                    spinStrokeWidth: 2,
                                    thumbDecoration: (value) => BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: value
                                              ? ColorConstants.gradient1
                                                  .withOpacity(0.2)
                                              : Colors.grey.shade200.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    onChange: (v) {},
                                    onTap: (v) {},
                                  ),
                                ],
                              ),
                            ))
                        .toList()),
                error: (e, s) => Text('Error $e'),
                loading: () => const CircularProgressIndicator(
                  color: ColorConstants.gradient1,
                ),
              ),
            ]),
          )),
    );
  }
}

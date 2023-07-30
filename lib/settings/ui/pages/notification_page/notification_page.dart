import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
                                  Switch(
                                      value: g.contains(e),
                                      activeColor: ColorConstants.gradient1,
                                      onChanged: (value) {
                                        if (value) {
                                          topicsNotifier.subscribeTopic(e);
                                        } else {
                                          topicsNotifier.unsubscribeTopic(e);
                                        }
                                      })
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

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/service/providers/topic_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/settings.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

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
              const AlignLeftText(
                SettingsTextConstants.updateNotification,
                padding: EdgeInsets.symmetric(vertical: 30),
                color: Color.fromARGB(255, 149, 149, 149),
              ),
              AsyncChild(
                  value: topics,
                  builder: (context, topic) => Column(
                      children: topic
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
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
                                        value: true,
                                        activeColor: ColorConstants.gradient1,
                                        onChanged: (value) {})
                                  ],
                                ),
                              ))
                          .toList()),
                  loaderColor: ColorConstants.gradient1),
            ]),
          )),
    );
  }
}

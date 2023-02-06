import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/refresher.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(allGroupListProvider);
    return Refresher(
        onRefresh: () async {},
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
                      color: Color.fromARGB(255, 205, 205, 205))),
            ),
            const SizedBox(
              height: 30,
            ),
            groups.when(
              data: (g) => Column(
                  children: g
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              error: (e, s) => Text('Error $e'),
              loading: () => const CircularProgressIndicator(
                color: ColorConstants.gradient1,
              ),
            ),
          ]),
        ));
  }
}

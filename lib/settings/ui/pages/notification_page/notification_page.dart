import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(allGroupListProvider);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(SettingsTextConstants.notifications,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: SettingsColorConstants.background2)),
          ),
          const SizedBox(
            height: 50,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(SettingsTextConstants.updateNotification,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: SettingsColorConstants.gradient1)),
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
                                      color:
                                          SettingsColorConstants.background2)),
                              Switch(
                                  value: true,
                                  activeColor: SettingsColorConstants.gradient1,
                                  onChanged: (value) {})
                            ],
                          ),
                        ))
                    .toList()),
            error: (e, s) => Text('Error $e'),
            loading: () => const CircularProgressIndicator(
              color: SettingsColorConstants.gradient1,
            ),
          ),
        ]));
  }
}

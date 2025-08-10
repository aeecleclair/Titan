import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:load_switch/load_switch.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/advert/class/announcer.dart';
import 'package:titan/advert/providers/announcer_list_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';

class LoadSwitchAdvertisers extends ConsumerWidget {
  const LoadSwitchAdvertisers({super.key, required this.group});
  final SimpleGroup group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcerListNotifier = ref.watch(announcerListProvider.notifier);

    final announcerList = ref.watch(announcerListProvider);

    return AsyncChild(
      value: announcerList,
      builder: (context, annoncerList) {
        final annoncer = annoncerList
            .where((a) => a.groupManagerId == group.id)
            .firstOrNull;
        final isAnnouncer = annoncerList.any(
          (a) => a.groupManagerId == group.id,
        );
        return LoadSwitch(
          value: isAnnouncer,
          future: isAnnouncer
              ? () async {
                  await announcerListNotifier.deleteAnnouncer(annoncer!);
                  return false;
                }
              : () async {
                  await announcerListNotifier.addAnnouncer(
                    Announcer(
                      groupManagerId: group.id,
                      id: '',
                      name: group.name,
                    ),
                  );
                  return true;
                },
          height: 30,
          width: 60,
          curveIn: Curves.easeInBack,
          curveOut: Curves.easeOutBack,
          animationDuration: const Duration(milliseconds: 500),
          switchDecoration: (value, _) => BoxDecoration(
            color: value
                ? Colors.red.withValues(alpha: 0.3)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: value
                    ? Colors.red.withValues(alpha: 0.2)
                    : Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          spinColor: (value) => value ? Colors.red : Colors.grey,
          spinStrokeWidth: 2,
          thumbDecoration: (value, _) => BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: value
                    ? Colors.red.withValues(alpha: 0.2)
                    : Colors.grey.shade200.withValues(alpha: 0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          onChange: (v) {},
          onTap: (v) {},
        );
      },
    );
  }
}

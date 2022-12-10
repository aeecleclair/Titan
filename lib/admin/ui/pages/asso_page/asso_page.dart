import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/providers/simple_groups_groups_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AssoPage extends HookConsumerWidget {
  const AssoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupNotifier = ref.watch(groupProvider.notifier);
    final groupId = ref.watch(groupIdProvider);
    final simplegroupsGroupsNotifier =
        ref.watch(simpleGroupsGroupsProvider.notifier);
    final simplegroupsGroups = ref.watch(simpleGroupsGroupsProvider);

    return Refresher(
      onRefresh: () async {
        await groupNotifier.loadGroup(groupId);
      },
      child: simplegroupsGroups.when(data: (value) {
        final g = value[groupId];
        if (g == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return g.when(data: (g) {
          if (g.isEmpty) {
            tokenExpireWrapper(ref, () async {
              final g = await groupNotifier.loadGroup(groupId);
              g.whenData((value) {
                simplegroupsGroupsNotifier.setTData(
                    groupId, AsyncData([value]));
              });
            });
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(capitalize(g[0].name),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.gradient1)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (g[0].description.isNotEmpty)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(g[0].description,
                          style: const TextStyle(fontSize: 18)),
                    ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("${AdminTextConstants.members} :",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  ...g[0].members.map((x) => Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(capitalize(x.getName()),
                          style: const TextStyle(fontSize: 18)))),
                  const SizedBox(height: 20),
                ],
              ));
        }, error: (e, s) {
          return Text(e.toString());
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(ColorConstants.gradient1),
            ),
          );
        });
      }, error: (e, s) {
        return Text(e.toString());
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(ColorConstants.gradient1),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_id_provider.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/refresher.dart';

class AssoPage extends HookConsumerWidget {
  const AssoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupProvider);
    final groupNotifier = ref.watch(groupProvider.notifier);
    final groupId = ref.watch(groupIdProvider);

    return Refresher(
      onRefresh: () async {
        await groupNotifier.loadGroup(groupId);
      },
      child: group.when(data: (g) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(capitalize(g.name),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gradient1)),
                ),
                const SizedBox(
                  height: 40,
                ),
                if (g.description.isNotEmpty)
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(g.description,
                        style: const TextStyle(fontSize: 18)),
                  ),
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("${AdminTextConstants.members} :",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                ...g.members.map((x) => Container(
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
      }),
    );
  }
}

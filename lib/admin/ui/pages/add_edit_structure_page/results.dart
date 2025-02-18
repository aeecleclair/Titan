import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/structure_manager_id_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class MemberResults extends HookConsumerWidget {
  const MemberResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final structureManagerIdNotifier =
        ref.watch(structureManagerIdProvider.notifier);

    return AsyncChild(
      value: users,
      builder: (context, value) => Column(
        children: value
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        e.getName(),
                        style: const TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        WaitingButton(
                          onTap: () async {
                            structureManagerIdNotifier.setId(e.id);
                            // TODO: Confirmation dialog
                          },
                          waitingColor: ColorConstants.gradient1,
                          builder: (child) => child,
                          child: const HeroIcon(HeroIcons.plus),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
      loaderColor: ColorConstants.gradient1,
    );
  }
}

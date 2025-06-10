import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/providers/string_provider.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/tools/constants.dart';

class ResearchBar extends HookConsumerWidget {
  const ResearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final editingController = useTextEditingController();
    final filterNotifier = ref.watch(searchFilterProvider.notifier);

    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              filterNotifier.setString(value);
            },
            focusNode: focusNode,
            controller: editingController,
            decoration: const InputDecoration(
              isDense: true,
              suffixIcon: Icon(Icons.search, size: 30),
              label: Text(
                SeedLibraryTextConstants.research,
                style: TextStyle(),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.gradient1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

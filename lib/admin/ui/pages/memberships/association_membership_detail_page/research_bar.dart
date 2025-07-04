import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/research_filter_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/tools/constants.dart';

class ResearchBar extends HookConsumerWidget {
  const ResearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final editingController = useTextEditingController();
    final filterNotifier = ref.watch(filterProvider.notifier);

    return TextField(
      onChanged: (value) {
        filterNotifier.setFilter(value);
      },
      focusNode: focusNode,
      controller: editingController,
      cursorColor: Color(0xFF1D1D1D),
      decoration: const InputDecoration(
        isDense: true,
        suffixIcon: Icon(Icons.search, color: Color(0xFF1D1D1D), size: 30),
        label: Text(
          AdminTextConstants.research,
          style: TextStyle(color: Color(0xFF1D1D1D)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.gradient1),
        ),
      ),
    );
  }
}

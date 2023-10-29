import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/providers/sharer_group_provider.dart';
import 'package:myecl/tricount/tools/constants.dart';
import 'package:myecl/tricount/ui/pages/tricount.dart';

class AddEditSharerGroupPage extends HookConsumerWidget {
  const AddEditSharerGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroup = ref.watch(sharerGroupProvider);
    final isEdit = sharerGroup.id != SharerGroup.empty().id;
    final name = useTextEditingController();
    return TricountTemplate(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
                key: key,
                child: Column(children: [
                  const SizedBox(height: 30),
                  AlignLeftText(
                    isEdit
                        ? TricountTextConstants.editGroup
                        : TricountTextConstants.addGroup,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    color: Colors.grey,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(children: [
                        const SizedBox(height: 30),
                        TextEntry(
                          label: TricountTextConstants.name,
                          controller: name,
                        ),
                      ]))
                ]))));
  }
}

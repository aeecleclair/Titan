import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/cinema/ui/text_entry.dart';

class AddEditAdvertPage extends HookConsumerWidget {
  const AddEditAdvertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advert = ref.watch(advertProvider);
    final isEdit = advert != Advert.empty();
    final title = useTextEditingController(text: advert.title);
    final content = useTextEditingController(text: advert.content);

    return SingleChildScrollView(
      child: Column(children: [
        TextEntry(
          keyboardType: TextInputType.text,
          label: AdvertTextConstants.title,
          suffix: '',
          isInt: false,
          controller: title,
          onChanged: (value) {},
        ),
        TextEntry(
          keyboardType: TextInputType.text,
          label: AdvertTextConstants.content,
          suffix: '',
          isInt: false,
          controller: content,
          onChanged: (value) {},
        ),
      ]),
    );
  }
}
